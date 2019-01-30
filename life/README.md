## Okchain Network Construction

### 1. 先启动lookup node

### 2. 再启动DS node
* 仍然用OKCHAIN_PEER_MODE指定DS身份
* 第一个连接到lookup节点的DS node为DS lead
* 之后连接到lookup节点的DS node为DS为 DS backup
* lookup node会介绍DS互相认识(发送 say hello 消息)

### 3. 启动sharding node
* 仍然用OKCHAIN_PEER_MODE指定sharding node身份
* lookup节点的介绍sharding node认识所有的DS node
* 收到第一个sharding node连接之后lookup节点就开始拒绝新的DS node接入网络

### 4. 通知网络开始运行POW
* 用okchaincli工具发送消息让lookup node通知所有的sharding node开始执行pow
* sharding node需要回复lookup node是否收到通知,以便在lookup node端记录日志
* lookup node释放内存中的通讯录(ds和sharding node的url)
* okchain开始出块，自治运行
