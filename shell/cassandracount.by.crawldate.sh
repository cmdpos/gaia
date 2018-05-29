#!/bin/bash

#echo "$1 article count on $3:"
#cqlsh -e "select count(*) from $1.article where $2='$3';"|grep -v "-"|grep -v rows|grep -v Aggregation|grep -v Warnings|grep -v count

KEY=$1
VALUE=$2
array=(baidu bjnews huxiu sm thecover ts36kr wukong baijiahao cyzone lieyun sogou tmtpost txweekly zhihu beiqing ebusinessreview sina sogou4weixin toutiao weibo)

function count {

for element in ${array[@]};  do	
    echo "$element article count by $KEY=$VALUE:"
    cqlsh -e "select count(*) from $element.article where $KEY='$VALUE';" \
      |grep -v "-"|grep -v rows|grep -v Aggregation|grep -v Warnings|grep -v count
done

}

count
