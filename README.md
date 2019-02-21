# Okchain 

## Development resources
+ 总结过去几个月工程进展
    * 技术选型
        * zilliqa 网络分片源代码
        * vrf
        * p2p 协议: gossip 
        * bls 多签
        * eth evm
        * 高效rocksdb: Leveldb的改进版，分表，io性能高
    * 难点和技术突破
        * 引入了p2p gossip
            * 消除了完全直连的网络通信。现在仅片内共识是PBFT直连，跨片通信都是gossip通信
            * 网络分片其实是个半中心化，半去中心化的网络，我们在天平两端之间寻找一个最佳的制衡点
            * 因为有中心化网络+互联网(用户可能随时离线)的基因，很多的工作处理这样的负向case:
        * 尝试vrf 取代pow，但是不能阻止女巫估计
            * 后面考虑使用vrf+pos，增加币龄的维度增加女巫攻击的成本
        * 用BLS取代EC-Schnorr 
        * 激励：给lead奖励，不要离线
        
    * 原型代码
    * 测试环境
        * 在公司局域网搭建了7-8台物理机的近100个节点-5个分片的的测试网，最长连续运行时间大概3周
        * 
    * 鲁棒性的挑战
        * 要让一个企业网络架构(中心化)运行在一个不稳定的网络环境(互联网，网络延时长，用户可能随时离线)
        * 中心化节点如果宕机或者突然离线
        * DS掉线backfill
        * POW结果收集时间窗口
        * DS收集N个分片的微块时间窗口
        * 分片内共识超时后，选举新lead再次发起共识
        
+ 总结过去几个月工程进展

