echo "======run cassandracount.sh"
ln -s cassandracount.sh execute.sh -f
sh runall.sh 

echo "======run ssdbcount.sh"
ln -s ssdbcount.sh execute.sh -f
sh runall.sh 

echo "======run display order"
ln -s display.sh execute.sh -f
sh runall.sh 
