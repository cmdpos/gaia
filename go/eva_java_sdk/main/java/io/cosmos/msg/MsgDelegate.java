package io.cosmos.msg;

import io.cosmos.msg.utils.*;
import io.cosmos.msg.utils.type.MsgDelegateValue;
import io.cosmos.types.*;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class MsgDelegate extends MsgBase {

    public static void main(String[] args) {
        MsgDelegate msg = new MsgDelegate();
        msg.setMsgType("cosmos-sdk/MsgDelegate");
        msg.init("2c999c5afe7f0c902846e1b286fed29c5c5914998655d469568560955abe0d5d");

        Messages[] messages = msg.produceDelegateMsg("cosmosvaloper1y5cj26cexle8mrpxfksnly2djzxx79zq2mf083", "stake", "100");

        msg.submit(messages,
                "stake",
                "3",
                "200000",
                "testchain",
                "Delegate memo");
    }


    protected Messages[] produceDelegateMsg(String validatorAddress, String delegateDenom, String delegateAmount) {

        MsgDelegateValue delegateValue = new MsgDelegateValue();
        delegateValue.setValidatorAddress(validatorAddress);
        delegateValue.setDelegatorAddress(address);
        //amount
        Token token = new Token();
        token.setDenom(delegateDenom);
        token.setAmount(delegateAmount);
        delegateValue.setAmount(token);
        Messages<MsgDelegateValue> messageDelegateMulti = new Messages<>();
        messageDelegateMulti.setType(msgType);
        messageDelegateMulti.setValue(delegateValue);
        Messages[] msgs = new Messages[1];
        msgs[0]=messageDelegateMulti;
        return msgs;
    }

}
