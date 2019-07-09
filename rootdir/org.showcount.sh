
echo "====================================="
echo "$1:"
echo "====================================="
echo "ssdb count:"
echo "hsize $1" | /root/qzhong/cdcproj/ssdb-master/tools/ssdb-cli cdc1|grep -v Copyright |grep -v  command|grep -v  help|grep -v  sec
echo "cassandra count:"
cqlsh -e "select count(*) from $1.article ;"|grep -v rows|grep -v Aggregation|grep -v Warnings|grep -v count
echo " "
