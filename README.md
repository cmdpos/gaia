20191202-20191206

## 1. 核心工作

1. OKChain主网分支代码分红和委托模块重构 ()
1. BTC跨链技术跟进
1. 调研cosmos-sdk ibc模块
1. Dex SDK开放计划
1. 调研Polka项目
1. 调研Polymath项目
1. Defi调研
1. 门罗币15.0冷钱包升级
1. 做市商接口开发

## 2. 本周问题/故障

无

## 3. 详细进展

1. OKChain主网分支代码bug修复, 分红和委托交易模型稳定性自测
   - dev分支staking模块回归cosmos sdk的高精度问题修复，现已同v0.6一致（100%）
   - dev分支distribution模块回归cosmos sdk的精度修复，分红策略修复（100%）
1. 基于okchain的稳定币POC
1. 双通证方案调研
1. BTC跨链技术跟进
   - BitcoinPeg 项目开源前期准备
     * 基于 BitcoinPeg 整理 Deposit 流程的详细设计(90%)
     * 面向 Deposit 流程的开发与本地测试(10%)

1. 调研cosmos-sdk ibc模块
   - cosmos-sdk ibc代码整理（client和connection创建部分代码整理完成）（80%）
   
1. Dex SDK开放计划
   - OKChain V2 Restful 接口，Java V2 SDK 开发完成，dev环境测试完成(95%）
   - Dex市商策略设计（80%, @白宇）
   - Dex市商策略开发（30%, @王亮）
   - Dex Java SDK 接入 Websocket (0%，本周未跟进)
   
1. 调研Polka项目
   - Rust语言基础、线程、安全模型学习（40%）
   - polka 私链搭建，已完成本地多节点中继链搭建，验证者选举，staking机制，基础运行脚本（60%）
   - 把上周分享的polkadot架构介绍内容整理到[wiki](http://gitlab.okcoin-inc.com/dex/okchain/wikis/polkadot-introduction)
1. 调研Polymath项目
   - 组内分享Polymath项目（100%）

1. Defi调研
   - Nervos调研，主要是经济机制部分（100%）
   - 双币模型分享（100%）

1. 门罗币15.0冷钱包升级
   - 移除spend key和seed info输出日志
   - 修复热钱包生成未花费交易时，选中使用范围外的UTXO问题

1. 做市商接口开发
   - 新增v2接口开发
   - 行情服务注册币对接口修改
   - 部署dev联调环境

  
   
## 4. 下周计划   