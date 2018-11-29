Shard
=====
|   shard     |   state   |    action          |
| :---------: |-----------|---------------- |
|             |POW_SUBMISSION|STARTPOW, PROCESS_DSBLOCK|
|             |WAITING_DSBLOCK|PROCESS_DSBLOCK|
|             |MICROBLOCK_CONSENSUS_PREP||
|             |MICROBLOCK_CONSENSUS|PROCESS_MICROBLOCKCONSENSUS|
|             |WAITING_FINALBLOCK|PROCESS_FINALBLOCK|
|             |FALLBACK_CONSENSUS_PREP||
|             |FALLBACK_CONSENSUS|PROCESS_FALLBACKCONSENSUS|
|             |WAITING_FALLBACKBLOCK|PROCESS_FALLBACKBLOCK|
|             |SYNC||

DS
===
|   ds        |   state   |    action         |
| :---------: |-----------|---------------- |
|             |POW_SUBMISSION|PROCESS_POWSUBMISSION, VERIFYPOW
|             |DSBLOCK_CONSENSUS_PREP|
|             |DSBLOCK_CONSENSUS|PROCESS_DSBLOCKCONSENSUS
|             |MICROBLOCK_SUBMISSION|PROCESS_MICROBLOCKSUBMISSION
|             |FINALBLOCK_CONSENSUS_PREP|
|             |FINALBLOCK_CONSENSUS|PROCESS_FINALBLOCKCONSENSUS
|             |VIEWCHANGE_CONSENSUS_PREP|
|             |VIEWCHANGE_CONSENSUS|PROCESS_VIEWCHANGECONSENSUS

Consensus messages
==================

| Message\Consensus  |Sent by |DSBlock| MircoBlock |FinalBlock|ViewChangeBlock|
| ------------------ | ---- |---  |------|------|------|
| Announce           | Lead   |  |      |     ||
| Commit             | Backup    |  |      |     ||
| Challenge          |Lead   |  |      |     ||
| Response           |Backup |    |      |      ||
| CollectiveSig      |Lead |  |      |       ||
| FinalCommit        |Backup |  |      |        ||
| FinalChallenge     |Lead  |  |      |        ||
| FinalResponse      |Backup |  |      |        ||
| FinalCollectiveSig |Lead |  |      |        ||


Lead
----
|   state     |  action    |
| :--------- |-----------|
|INITIAL|SEND_ANNOUNCEMENT, PROCESS_COMMITFAILURE|
|ANNOUNCE_DONE|PROCESS_COMMIT, PROCESS_COMMITFAILURE|
|CHALLENGE_DONE|PROCESS_RESPONSE, PROCESS_COMMITFAILURE|
|COLLECTIVESIG_DONE|PROCESS_FINALCOMMIT, PROCESS_COMMITFAILURE|
|FINALCHALLENGE_DONE|PROCESS_FINALRESPONSE, PROCESS_COMMITFAILURE|
|DONE|PROCESS_COMMITFAILURE|



Backup
------
|   state     |  action    |
| :--------- |-----------|
|INITIAL|PROCESS_ANNOUNCE|
|COMMIT_DONE|PROCESS_CHALLENGE, PROCESS_COLLECTIVESIG, PROCESS_FINALCOLLECTIVESIG|
|RESPONSE_DONE|PROCESS_CHALLENGE, PROCESS_COLLECTIVESIG, PROCESS_FINALCOLLECTIVESIG|
|FINALCOMMIT_DONE|PROCESS_FINALCHALLENGE, PROCESS_FINALCOLLECTIVESIG|
|FINALRESPONSE_DONE|PROCESS_FINALCHALLENGE, PROCESS_FINALCOLLECTIVESIG|
|||


Ds Message
----------
DS_SetPrimary = 100;
DS_PoWSubmission = 101;
DS_DSBlockConsensus = 102;
DS_MicroblockSubmission = 103;
DS_FinalBlockConsensus = 104;
DS_ViewChangeConsensus = 105;
VCPUSHLATESTDSTXBLOCK = 106,

Sharding Message
----------------
Node_ProcessStartPoW = 200;
Node_ProcessDSBlock = 201;
Node_MircoBlockConsensus = 202;
Node_ProcessFinalBlock = 203;
Node_ViewChangeConsensus = 204;
Node_ProcessCreateTransaction = 205;
Node_BroadcastTransactions = 206;

Consensus Message
-----------------
Consensus_Announce = 301;
Consensus_Commit = 302;
Consensus_Challenge = 303;
Consensus_Response = 304;
Consensus_CollectiveSig = 305;
Consensus_FinalCommit = 306;
Consensus_FinalChallenge = 307;
Consensus_FinalResponse = 308;
Consensus_FinalCollectiveSig = 309;

```
  enum ConsensusMessageType : unsigned char {
    ANNOUNCE = 0x00,
    COMMIT = 0x01,
    CHALLENGE = 0x02,
    RESPONSE = 0x03,
    COLLECTIVESIG = 0x04,
    FINALCOMMIT = 0x05,
    FINALCHALLENGE = 0x06,
    FINALRESPONSE = 0x07,
    FINALCOLLECTIVESIG = 0x08,
    COMMITFAILURE = 0x09,
    CONSENSUSFAILURE = 0x10,
  };
```










### 2.1 ds

|       消息类型       |             作用              |
| :------------------: | :---------------------------: |
|       StartPow       | 发送消息到普通节点开始计算pow |
|    PowSubmission     |      提交pow结果到委员会      |
|   DSBlockConsensus   |         DS块开始共识          |
| MicroBlockSubmission | 分片节点把微块提交到委员会DS  |
| FinalBlockConsensus  |         最终块的共识          |

### 2.2 分片节点

|      消息类型       |             作用              |
| :-----------------: | :---------------------------: |
|       DSBlock       | 委员会通知分片节点处理DSBlock |
|  CreateTransaction  |     通知分片节点创建交易      |
| MicroBlockConsensus |         开始微块共识          |
|     FinalBlock      |   委员会通知同步FinalBlock    |

### 2.3 共识消息

|      消息类型      | 作用 |
| :----------------: | :--: |
|      Announce      |      |
|       Commit       |      |
|     Challenge      |      |
|      Response      |      |
|   CollectiveSig    |      |
|    FinalCommit     |      |
|   FinalChallenge   |      |
|   FinalResponse    |      |
| FinalCollectiveSig |      |

## 3 通信的详细参数

### 3.1 委员会

1. StartPow参数
   * 无参数
2. PowSubmission
   - BlockNumber: 校验是否是最新的block
   - ListenPort：端口号
   - PublicKey: 公钥
   - Nonce: nonce值，pow的解决方案
   - ResultHash: 计算出的hash
   - MixHash:根据nonce计算出来的用来检测dos攻击
   - Sign:签名
   - Peer:包含节点的ip和端口号
3. DSBlockConsensus
   * ConsensusType:  共识类型，具体见2.3
   * ConsensusMsg: 共识的消息
   * Peer: 包含节点的ip和端口号
4. MicroBlockSubmission
   * DsBlockNum: 最新的ds块号
   * ConsensusId: 共识的id，用于校验是否是同一轮共识
   * ShardID: 分片id
   * TxMicroblock: 微块
   * Peer: 包含节点的ip和端口号
5. FinalBlockConsensus
   * ConsensusType:  共识类型，具体见2.3
   * ConsensusMsg: 共识的消息
   * Peer: 节点的ip和端口号

委员会节点的grpc的proto定义如下：

```protobuf
service Committee {
	// StartPow
    rpc StartPow(google.protobuf.Empty) returns (Response) {}
    // PowSubmission
    rpc PowSubmission(PowSpec) returns (Response) {}
    // DSBlockConsensus
    rpc DSBlockConsensus(ConsensusSpec)  returns (Response) {}
    // MicroBlockSubmission
    rpc MicroBlockSubmission(MicroblockSpec) returns (Response) {}
    // FinalBlockConsensus
    rpc FinalBlockConsensus(ConsensusSpec) returns (Response) {}
}

// pow specification
message PowSpec{
    int32 blockNum = 1;
    string listenPort = 2;
    bytes pubKey = 3;
    int32 nonce = 4;
    bytes resultHash = 5;
    bytes mixHash = 6;
    bytes sign = 7;
}

// consensus specification
message ConsensusSpec {
    enum ConsensusType {
        Announce = 1;
        Commit = 2;
        Challenge = 3;
        Response = 4;
        CollectiveSig = 5;
        FinalCommit = 6;
        FinalChallenge = 7;
        FinalResponse = 8;
        FinalCollectiveSig = 9;
    }
    ConsensusType consensusType = 1;
    bytes consensusMsg = 2;
}

// microblock specification
message MicroblockSpec {
    int32 dsblockNum = 1;
    int32 consensusID = 2;
    int32 shardID = 3;
    TxMicroblock txMicroblock = 4;
}

message TxMicroblock {}

message Response {
    enum StatusCode {
        UNDEFINED = 0;
        SUCCESS = 200;
        FAILURE = 500;
    }
    StatusCode status = 1;
    bytes msg = 2;
}
```

### 3.2 分片节点

1. ProcessDsBlock
   * DsBlock: DS块的信息
   * DsBlockHash/rand: DsBlockHash/rand
   * WinnerIP：胜者的ip
   * WinnerPort: 胜者的端口号
   * Peer: 节点的ip和端口号
2. ProcessCreateTransaction
   * from: from的公钥
   * to: to的公钥
   * Amount: 转账数
   * Peer：节点的ip和端口号
3. MicroBlockConsensus
   - ConsensusType:  共识类型，具体见2.3
   - ConsensusMsg: 共识的消息
   - Peer: 节点的ip和端口号
4. FinalBlock
   * DSBlockNum: ds块的num
   * ConsensusID: 共识id
   * ShardID：分片id
   * FinalBlock: 最终块
   * TxbodySharingSetup

分片节点的grpc的proto定义如下：

```protobuf
service ShardingNode {
	// ProcessDsBlock
	rpc ProcessDsBlock(DsBlockSpec) returns (Response) {}
	// ProcessCreateTransaction
	rpc ProcessCreateTransaction(Transaction) returns (Response) {}
	// MicroBlockConsensus
	rpc MicroBlockConsensus(ConsensusSpec) returns (Response) {}
	// FinalBlock
	rpc FinalBlock(FinalblockSpec) returns (Response) {}
}

// DsBlockSpec
message DsBlockSpec {
    DsBlock dsBlock = 1;
    int32 dsBlockHashRand = 2;
    string winnerIP = 3;
    string winnerPort = 4;
}

// transaction
message Transaction {
    bytes from = 1;
    bytes to = 2;
    int64 amount = 3;
}

// FinalblockSpec
message FinalblockSpec {
    int32 dsBlockNum = 1;
    int32 consensusID = 2;
}

// Finalblock
message FinalBlock {}
```

### 3.3 共识通信过程

网络分片过程中有多个模块都用到了共识，包括分片的共识，分片节点间microblock的共识，委员会节点间finalblock的共识等，共识的核心通信逻辑都一样，具体时序图如下图所示：

![共识时序图](../doc/zil_consensus.png)



#### 3.3.1 leader节点

1. ProcessMessageCommit
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * BackupID: backup节点的id
   * Commit: commit消息
   * Signature: 签名信息
2. ProcessMessageResponse
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * BackupID: backup节点的id
   * Response: response消息
   * Signature: 签名信息
3. ProcessMessageFinalCommit
   - ConsensusID: 共识id
   - BlockHash: 区块的hash
   - BackupID: backup节点的id
   - Commit: commit消息
   - Signature: 签名信息
4. ProcessMessageFinalResponse
   - ConsensusID: 共识id
   - BlockHash: 区块的hash
   - BackupID: backup节点的id
   - Response: final response消息
   - Signature: 签名信息

#### 3.3.2 backup节点

1. ProcessMessageAnnounce
   - ConsensusID: 共识id
   - BlockHash: 区块的hash
   - LeaderID: leader节点的id
   - Messsage: message消息
   - Cosign: 共同签名
   - Signature: 签名信息
2. ProcessMessageChallenge
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * LeaderID: leader的id
   * AggregatedCommit: 合计的commit
   * AggregatedKey: 合计的key
   * Challenge: Challenge消息
   * Signature: 签名
3. ProcessMessageFinalChallenge
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * LeaderID: leader的id
   * AggregatedCommit: 合计的commit
   * AggregatedKey: 合计的key
   * Challenge: Challenge消息
   * Signature: 签名
4. ProcessMessageCollectiveSig
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * LeaderID: leader的id
   * NBitmap: 多签用到的bitmap
   * CoSignature：共同签名
   * signature：签名，基于上面五个字段的签名
5. ProcessMessageFinalCollectiveSig
   * ConsensusID: 共识id
   * BlockHash: 区块的hash
   * LeaderID: leader的id
   * NBitmap: 多签用到的bitmap
   * CoSignature：共同签名
   * signature：签名，基于上面五个字段的签名

由于共识过程leader节点与backup节点之间需要多次来回通信，因此使用grpc的stream的通信方式，具体proto定义如下图所示：

```protobuf
service Consensus {
    rpc Chat(stream ConsensusMsg) returns (stream ConsensusMsg) {}
}

message ConsensusMsg {
    oneof consensusmsg {
        Announce announce = 1;
        Commit commit = 2;
        Challenge challenge = 3;
        Response response = 4;
        Collectivesig collectivesig = 5;
        Finalcommit finalcommit = 6;
        Finalchallenge finalchallenge = 7;
    }
}

message Announce {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 leaderID = 3;
    bytes msg = 4;
    bytes cosign = 5;
    bytes signature = 6;
}

message Commit {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 backupID = 3;
    bytes commitMsg = 4;
    bytes signature = 5;
}

message Challenge {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 leaderID = 3;
    bytes aggregatedCommit = 4;
    bytes aggregatedKey = 5;
    bytes challengeMsg = 6;
    bytes signature = 6;
}

message Response {
	int32 consensusID = 1;
	bytes blockHash = 2;
	int32 backupID = 3;
	bytes responseMsg = 4;
    bytes signature = 5;
}

message CollectiveSig {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 leaderID = 3;
    repeated bool nmap = 4;
    bytes cosignature = 5;
    bytes signature = 6;
}

message FinalCommit {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 backupID = 3;
    bytes commitMsg = 4;
    bytes signature = 5;
}

message FinalChallenge {
    int32 consensusID = 1;
    bytes blockHash = 2;
    int32 leaderID = 3;
    bytes aggregatedCommit = 4;
    bytes aggregatedKey = 5;
    bytes challengeMsg = 6;
    bytes signature = 6;
}

message FinalResponse {
    int32 consensusID = 1;
	bytes blockHash = 2;
	int32 backupID = 3;
	bytes responseMsg = 4;
    bytes signature = 5;
}
```





