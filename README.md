inflationRateChangePerYear是一年的通胀率变话值，正负取决于当前抵押率(bondedRatio)和目标抵押率(GoalBonded)即67%。

MaxInflationRateChange是从7%~20%变化的最大步长即13%

inflationRateChangePerYear = (1 – bondedRatio / GoalBonded) * MaxInflationRateChange
将整年的通胀率变化平摊到每个块上，

算出上一个块到当前块的通胀率变化值（inflationRateChange）inflationRateChange := inflationRateChangePerYear  / BlocksPerYear

计算当前块的通胀率：currBlockInflationRate = preBlockInflationRate + inflationRateChange

计算当前块增发量：
currBlockInflation = totalSupply * currBlockInflationRate





# 20191230-20200103

## 1. 核心工作

1. OKChain测试网v0.8测试 (95%)
2. OKChain智能合约POC (70%)
3. 去中心化的期权 & 期货交易POC (30%)
4. Cosmos-sdk 跨链模块开发 (%)
5. 开源公链项目调研 (%)

## 2. 本周问题/故障
无

## 3. 详细进展

1. OKChain测试网v0.8 (95%)
   - OKChainv0.8 & DEXv0.8 已部署至预发环境，进度100%
   - 完成撮合，撤单，订单过期手续费收取单测
   - 市商策略挂单程序已稳定运行 (100%)
   - QA开始本周五开始测试
   - OKChain文档主题，完成多语言支持。进度80%
   
2. OKChain智能合约POC (70%)
	- Fomo3D合约key计价、分红、战队规则、round管理、时间管理（70%）
	- ERC20合约接口转账、余额查询（70%） 

3. 去中心化的期权 & 期货交易POC (30%)
    - 永续合约wiki整理（100%）
    - 期权业务调研和分享 （100%）
    - 期权设计方案 (10%)
    
4. Cosmos-sdk 跨链模块开发 (%)
   - 给社区提报一个跨链bug
   - 与Cosmos ibc社区人员沟通，如何合作贡献代码
   
5. 开源公链项目调研 (%)
   - Nervos深入调研激励策略 (100%)
   - 调研Polka项目
        - rust学习分享并整理文档到wiki（100%）
        - polkadot上实现dex调研（20%）
   - 调研波场架构、网络节点、共识、协议、经济模型等调研(60%)
   - 调研非同质化代币NFT（30%）
   - Filecoin与IPFS基础概念调研（100%）
   - 整理Cosmos经济模型发行、质押、分红、验证者轮替、链上治理（100%）

## 4. 下周计划   
1. OKChain测试网文档更新    
2. Dex SDK             
3. OKChain主网分支dev稳定性测试   
4. OKChain主网分支v0.8测试
5. BTC & OKChain 跨链    
6. Cosmos-sdk 跨链模块开发
12. 调研非同质化代币NFT
13. 基于dev分支的批量下单撤单开发
14. okchainv0.8分支完善order手续费单测
15. Filecoin 调研
16. Cosmos 经济模型调研