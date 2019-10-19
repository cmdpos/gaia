package io.cosmos.msg;

import io.cosmos.msg.utils.*;
import io.cosmos.msg.utils.type.MsgSendValue;
import io.cosmos.types.*;

import java.util.ArrayList;
import java.util.List;



// Register concrete types on codec codec
//func RegisterCodec(cdc *codec.Codec) {
//        cdc.RegisterConcrete(MsgWithdrawDelegatorReward{}, "cosmos-sdk/MsgWithdrawDelegationReward", nil)
//        cdc.RegisterConcrete(MsgWithdrawValidatorCommission{}, "cosmos-sdk/MsgWithdrawValidatorCommission", nil)
//        cdc.RegisterConcrete(MsgSetWithdrawAddress{}, "cosmos-sdk/MsgModifyWithdrawAddress", nil)
//        }


public class MsgSend extends MsgBase {

    public static void main(String[] args) {
        MsgSend msg = new MsgSend();
        msg.setMsgType("cosmos-sdk/MsgSend");
        msg.init("2c999c5afe7f0c902846e1b286fed29c5c5914998655d469568560955abe0d5d");

        Messages[] messages = msg.produceSendMsg("stake",
                "16",
                "cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0");

        msg.submit(messages,
                "stake",
                "6",
                "200000",
                "testchain",
                "cosmos transfer");
    }



    private Messages[] produceSendMsg(String denom, String amountDenom, String to) {

        List<Token> amountList = new ArrayList<>();
        Token amount = new Token();
        amount.setDenom(denom);
        amount.setAmount(amountDenom);
        amountList.add(amount);

        MsgSendValue value = new MsgSendValue();
        value.setFromAddress(this.address);
        value.setToAddress(to);
        value.setAmount(amountList);

        Messages<MsgSendValue> msg = new Messages<>();
        msg.setType(msgType);
        msg.setValue(value);
        Messages[] msgs = new Messages[1];
        msgs[0] = msg;
        return msgs;
    }

}
