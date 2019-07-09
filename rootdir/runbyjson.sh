#!/bin/bash

keyword=task_controller
ps -ef|grep $keyword|grep -v grep |awk '{print "kill -9 "$2}'
ps -ef|grep $keyword|grep -v grep |awk '{print "kill -9 "$2}'|sh

keyword=phantomjs
ps -ef|grep $keyword|grep -v grep |awk '{print "kill -9 "$2}'
ps -ef|grep $keyword|grep -v grep |awk '{print "kill -9 "$2}'|sh

nohup python ./task_controller.py $1>>analysis.log 2>&1 &
ps -ef|grep task_controller|grep -v grep |awk '{print "New controller processid: "$2}'
