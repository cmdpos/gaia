package io.cosmos.msg;

import io.cosmos.msg.utils.Messages;

public class MsgUnbond extends MsgDelegate {

    public static void main(String[] args) {
        MsgUnbond msg = new MsgUnbond();
        msg.setMsgType("cosmos-sdk/MsgUndelegate");
        msg.init("2c999c5afe7f0c902846e1b286fed29c5c5914998655d469568560955abe0d5d");

        Messages[] messages = msg.produceDelegateMsg("cosmosvaloper1y5cj26cexle8mrpxfksnly2djzxx79zq2mf083",
                "stake", "100");

        msg.submit(messages,
                "stake",
                "3",
                "200000",
                "testchain",
                "Delegate memo");
    }

}
