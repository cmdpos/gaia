## XMR转账状态

### T0
From用输入input_tx发起转账给To，提交到网络中后，获得新交易id为new_tx


### T1
new_tx被打包到区块H中
* 在From端:
  + input_tx的spentHeight 从0变为H
  + 收到一个找零交易，id为new_tx
  + new_tx的blockHeight 为H
  + 可以执行导入new_tx的keyimage
   
* 在To端:
  + 收到一个income交易，id为new_tx
  + new_tx的blockHeight 为H
  + 可以执行导入new_tx的keyimage
   


### T2
在区块H+10，new_tx满足10个区块确认可以被花费

* 在From端:
  + 找零交易new_tx满足10个区块确认可以被花费
   
* 在To端:
  + income交易new_tx满足10个区块确认可以被花费


