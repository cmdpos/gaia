package io.cosmos.msg;

import io.cosmos.msg.utils.Messages;
import io.cosmos.msg.utils.type.MsgSendValue;
import io.cosmos.msg.utils.type.MsgSetWithdrawAddrValue;
import io.cosmos.types.Token;

import java.util.ArrayList;
import java.util.List;

public class MsgSetWithdrawAddress extends MsgBase {

    public static void main(String[] args) {
        MsgSetWithdrawAddress msg = new MsgSetWithdrawAddress();
        msg.setMsgType("cosmos-sdk/MsgModifyWithdrawAddress");
        msg.init("2c999c5afe7f0c902846e1b286fed29c5c5914998655d469568560955abe0d5d");

        Messages[] messages = msg.produceMsg("cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h");

        msg.submit(messages,
                "stake",
                "6",
                "200000",
                "testchain",
                "cosmos set withdrawAddr");
    }

    private Messages[] produceMsg(String withdrawAddr) {

        MsgSetWithdrawAddrValue value = new MsgSetWithdrawAddrValue();
        value.setWithdrawAddress(withdrawAddr);
        value.setDelegatorAddress(this.address);

        Messages<MsgSetWithdrawAddrValue> msg = new Messages<>();
        msg.setType(msgType);
        msg.setValue(value);
        Messages[] msgs = new Messages[1];
        msgs[0] = msg;
        return msgs;
    }

}
