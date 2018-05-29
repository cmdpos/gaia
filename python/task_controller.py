# -*- coding: utf-8 -*-
"""
@Time    : 2018/01/06
@Author  : zhongqiu
@File    : spider_controller.py
"""


import sys
import subprocess
import threading
import Queue
import logging
import json
import os
import time
import threadpool
import codecs
from time import sleep
from copy import deepcopy
from kafka import KafkaConsumer

class ConfigLoader(object):
    """
    爬虫控制器配置加载类
    """
    def __init__(self, conf_name):
        """
        init
        :param conf_name:
        """
        self.conf_name = conf_name
        self.json_conf = None
        self.task_cmd = {}

    def load_config(self):
        """
        加载配置
        :return True/False:
        """
        try:
            (dirname, filename) = os.path.split(os.path.abspath(sys.argv[0]))
            conf = os.path.join(dirname, self.conf_name)
            if not os.path.exists(conf):
                return False

            json_file = codecs.open(conf, encoding='utf-8')
            self.json_conf = json.load(json_file)
            json_file.close()

            self.cdc_top = self.json_conf.get('cdc_top', None)
            self.workdir = os.path.join(self.cdc_top, self.json_conf.get('workdir', None))
            self.tasks = []

            task_list = self.json_conf.get('tasks', None)
            for task in task_list:
                dict = deepcopy(task)
                del dict['child_task_commands']
                task_cmd = {}
                child_task_list = task.get('child_task_commands', None)
                for child_task in child_task_list:
                    child = {}
                    child['child_cmd'] = os.path.join(self.cdc_top, child_task['child_cmd'])
                    child['child_workdir'] = self.workdir

                    child_workdir = child_task.get('child_workdir', None)
                    if child_workdir is not None:
                        child['child_workdir'] = os.path.join(self.cdc_top, child_workdir)

                    task_cmd[child_task['task_type']] = child
                dict['child_cmd'] = task_cmd
                self.tasks.append(dict)

        except Exception as e:
            print 'load_config: %s' % e
            logging.error('load_config:: %s.' % e)
        return True

    def get_workdir(self):
        """
        get_workdir
        """
        return self.workdir

    def get_tasks(self):
        """
        get_tasks
        """
        return self.tasks

glock = threading.Lock()

class KafkaMessageConsumer(object):
    """
    task控制器，用于支持多级部署，从kafka集群获取爬取任务并根据自身配置执行相关调度；
    """
    def __init__(self, task_map):
        """
        __init__
        """
        self.taskmgr = None
        self.child_cmd = task_map['child_cmd']
        self.brokers = task_map['brokers']
        self.concurrent_task = task_map['concurrent_task']
        self.topic = task_map['topic']
        self.group_id = task_map['group_id']
        self.mode = task_map['mode']
        self.task_queue = Queue.Queue()

    def run(self):
        """
        run
        """
        try:

            if str(self.mode) == 'spider':
                print 'SpiderTaskManager: %s' % str(self.mode)
                self.taskmgr = SpiderTaskManager()
            else:
                print 'AnalysisTaskManager: %s' % str(self.mode)
                self.taskmgr = AnalysisTaskManager()

            threadids = []
            index = 0
            while index < self.concurrent_task:
                index += 1
                threadids.append(str(index))

            pool = threadpool.ThreadPool(self.concurrent_task)
            requests = threadpool.makeRequests(self.__thread_func, threadids)
            [pool.putRequest(req) for req in requests]

            consumer_thread_id = ['consumer']
            consumer_thread = threadpool.ThreadPool(1)

            if str(self.topic) == 'test_task_topic':
                requests = threadpool.makeRequests(self.__runtest, consumer_thread_id)
            else:
                requests = threadpool.makeRequests(self.__run, consumer_thread_id)

            [consumer_thread.putRequest(req) for req in requests]
        except Exception as e:
            logging.error('Failed to execute KafkaMessageConsumer run: %s.' % e)
            print ('Failed to execute KafkaMessageConsumer run: %s.' % e)

    def __run(self, consumer_thread_id):
        consumer = KafkaConsumer(self.topic,
                                 bootstrap_servers=self.brokers, group_id=self.group_id)
        print 'start kafka consumer thread, topic: %s\n' % self.topic
        logging.info('start kafka consumer thread, topic: %s', self.topic)
        while True:
            logging.info('__run: start kafka consumer thread, topic: %s', self.topic)

            for msg in consumer:
                self.__check_pending_tasks(500)
                self.__on_kafka_message(msg)
        pass

    def __on_test_message(self, taskType):
        try:
            task_payload = {}
            task_payload['task_type'] = taskType
            task_payload['dummy'] = taskType

            self.taskmgr.enqueue(task_payload)
        except Exception as e:
            logging.error('Failed to handle test_message: %s.' % e)

    def __runtest(self, consumer_thread_id):
        print 'start __runtest thread, topic: %s\n' % self.topic
        logging.info('start kafka consumer thread, topic: %s', self.topic)
        while True:
            logging.info('__runtest: start test thread, topic: %s', self.topic)
            self.__on_test_message('test1')
            self.__on_test_message('test2')
            self.__on_test_message('test3')
            time.sleep(10)
        pass

    def __check_pending_tasks(self, max_pending):
        try:
            while True:
                qsize = self.taskmgr.get_pending_task_num()
                if qsize < max_pending:
                    logging.info('pending queue size: %s. resuming enqueue!' % qsize)
                    break
                else:
                    logging.info('pending queue is full: %s. suspending enqueue!' % qsize)
                    time.sleep(60)

        except Exception as e:
            logging.error('Failed to __check_pending_tasks: %s.' % e)
        pass

    def __on_kafka_message(self, msg):
        try:
            task_info = json.loads(msg.value)
            task_payload = task_info['task_payload']
            self.taskmgr.enqueue(task_payload)
        except Exception as e:
            logging.error('Failed to handle kafka_message: %s.' % e)

    def __thread_func(self, threadid):
        while True:
            logging.info('start executing <%s> task', self.topic)
            print 'start <%s> working thread\n' % self.topic

            task = self.taskmgr.dequeue()
            self.__execute_task(task)
            self.taskmgr.on_task_completed(task)

    def __get_child_cmd(self, task_type):
        return self.child_cmd.get(task_type)['child_cmd']

    def __get_child_workdir(self, task_type):
        return self.child_cmd.get(task_type)['child_workdir']

    def __get_child_config(self, task, field):
        return self.child_cmd.get(task.get('task_type'))[field]

    def __execute_task(self, task):
        try:
            cmd = self.__get_child_cmd(task.get('task_type', None))
            if cmd is None or len(cmd) == 0:
                logging.error('No command configured for:' % task.get('task_type'))
                return

            task_list = []
            task_list.append(task)
            task_key = self.taskmgr.get_task_key(task)

            param = json.dumps(task_list)
            logging.info('Running task<%s>: %s' % (task_key, param))

            ts1 = time.time()
            t1 = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(ts1))

            glock.acquire()
            parent_workdir = os.getcwd()
            child_workdir = self.__get_child_config(task, 'child_workdir')

            logging.info('in glock.acquire(), task_type<%s>, parent_workdir=%s, child_workdir=%s' %
                         (task.get('task_type'), parent_workdir, child_workdir))

            os.chdir(child_workdir)
            child_proc = subprocess.Popen(['python', cmd, '-j', param])
            os.chdir(parent_workdir)
            # logging.info('sleeping...')
            # time.sleep(10)

            logging.info('out glock.release(), task_type<%s>, parent_workdir=%s, child_workdir=%s' %
                         (task.get('task_type'), parent_workdir, child_workdir))
            glock.release()
            rcode = child_proc.wait()

            ts2 = time.time()
            t2 = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(ts2))

            logging.info('%s: <%s> done with <%s>, took <%s> second(s), [%s]--[%s]' %
                         (self.topic, task_key, rcode, ts2 - ts1, t1, t2))

        except Exception as e:
            glock.release()
            logging.error('Failed to execute task: %s. %s' % (task, e))

class TaskController(object):
    """
    task控制器，用于支持多级部署，从kafka集群获取爬取任务并根据自身配置执行相关调度；
    """
    def __init__(self, config):
        """
        __init__
        """
        logging.basicConfig(level=logging.INFO,
                            format='%(asctime)s %(filename)s[line:%(lineno)d] '
                                   '[%(process)d:%(threadName)s] %(levelname)s: %(message)s',
                            datefmt='%Y-%m-%d %H:%M:%S',
                            filename='info.txt',
                            filemode='aw')

        self.config_loader = ConfigLoader(config)

    def run(self):
        """
        run
        """
        try:
            if not self.config_loader.load_config():
                print 'load config error.'
                exit()

            workdir = self.config_loader.get_workdir()

            if workdir is not None:
                os.chdir(workdir)
                logging.info('move to workdir: %s. os.getcwd(): %s' % (workdir, os.getcwd()))

            task_list = self.config_loader.get_tasks()
            for t in task_list:
                if t.get('enable', '') == "True":
                    consumer = KafkaMessageConsumer(t)
                    consumer.run()
            while True:
                time.sleep(30)
        except Exception as e:
            logging.error('Failed in TaskController run: %s.' % e)


class SpiderTaskManager(object):
    """
    Define
    """
    def __init__(self):
        """
        :return:
        """
        self.task_lock = threading.Lock()
        self.running_task = {}
        self.task_queue = Queue.Queue()

    def get_pending_task_num(self):
        """
        :return:
        """
        return self.task_queue.qsize()

    def enqueue(self, task):
        """
        :return:
        """
        try:
            self.task_queue.put(task)
            logging.info('Enqueue: current queue size: %s'
                         % self.task_queue.qsize())

            # if self.task_queue.qsize() < 500:
            #     self.task_queue.put(task)
            #     logging.info('Enqueue: task_queue size: %s'
            #                  % self.task_queue.qsize())
            # else:
            #     logging.info('Ignore task. task_queue size: %s'
            #                  % self.task_queue.qsize())

        except Exception as e:
            logging.error('Failed to enqueue task: %s. %s'
                         % (task, e))

    def dequeue(self):
        """
        :return:
        """
        while True:
            task = self.task_queue.get()
            logging.info('Dequeue: task_queue size: %s' %
                         self.task_queue.qsize())

            self.task_lock.acquire()
            try:
                task_name = self.get_task_key(task)
                if task_name in self.running_task:
                    logging.warning('Discard <%s> task due to the existing running task.'
                                 % task_name)
                    self.task_queue.task_done()
                else:
                    self.running_task[task_name] = task
                    self.task_lock.release()
                    break
            except Exception as e:
                logging.error('Failed to dequeue task. %s' % e)
            self.task_lock.release()

        return task

    def on_task_completed(self, task):
        """
        :on_task_completed:
        """
        self.task_queue.task_done()
        self.task_lock.acquire()
        try:
            del self.running_task[self.get_task_key(task)]
        except Exception as e:
            logging.error('Failed to rm task: %s. %s' % (task, e))
        self.task_lock.release()

    def get_task_key(self, task):
        """
        :return:
        """
        return '[%s][%s]' % (task.get('spider', None), task.get('keyword', None))


class AnalysisTaskManager(SpiderTaskManager):
    """
    Define
    """
    def dequeue(self):
        """
        :return:
        """
        try:
            task = self.task_queue.get()
        except Exception as e:
            logging.error('Failed to dequeue task. %s' % e)
        return task

    def get_task_key(self, task):
        """
        :return:
        """
        return task.get('task_name', None)

    def on_task_completed(self, task):
        """
        :return:
        """
        pass

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf8')
    try:
        config = 'spider_task.json'
        if len(sys.argv) == 2:
            config = sys.argv[1]

        controller = TaskController(config)
        controller.run()
    except Exception as e:
        print e
    pass
