#!/bin/bash
keyword=kafka.Kafka
KAFKA_TOP=/usr/local/kafka

ps -ef|grep $keyword |grep -v grep |awk '{print "kill -9 "$2}'
$KAFKA_TOP/bin/kafka-server-stop.sh

sleep 6
ps -ef|grep $keyword |grep -v grep |awk '{print "kill -9 "$2}'
kill -9 $(ps -ef|grep $keyword |awk '$0 !~/grep/ {print $2}' |tr -s '\n' ' ')

rm -rf  /tmp/kafka-logs-0/*
rm -rf  /tmp/kafka-logs-1/*
rm -rf  /tmp/kafka-logs-2/*

sleep 2
$KAFKA_TOP/bin/kafka-server-start.sh $KAFKA_TOP/config/server.properties  > /etc/null &

ps -ef|grep $keyword |grep -v grep |awk '{print "New kafka processid: "$2}'
