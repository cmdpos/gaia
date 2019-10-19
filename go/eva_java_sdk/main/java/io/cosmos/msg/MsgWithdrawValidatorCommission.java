package io.cosmos.msg;

import io.cosmos.msg.utils.Messages;
import io.cosmos.msg.utils.type.MsgWithdrawDelegatorRewardValue;
import io.cosmos.msg.utils.type.MsgWithdrawValidatorCommissionValue;

public class MsgWithdrawValidatorCommission extends MsgBase {

    public static void main(String[] args) {
        MsgWithdrawValidatorCommission msg = new MsgWithdrawValidatorCommission();
        msg.setMsgType("cosmos-sdk/MsgWithdrawValidatorCommission");
        String mnemonic = "sentence deputy little switch fiction balcony hollow iron net index sound hollow scare attitude only cushion best candy wonder phone napkin sketch announce derive";
        msg.initMnemonic(mnemonic);

        Messages[] messages = msg.produceMsg("cosmosvaloper1y5cj26cexle8mrpxfksnly2djzxx79zq2mf083");

        msg.submit(messages,
                "stake",
                "6",
                "200000",
                "testchain",
                "cosmos withdraw");
    }

    private Messages[] produceMsg(String validatorAddr) {

        MsgWithdrawValidatorCommissionValue value = new MsgWithdrawValidatorCommissionValue();
        value.setValidatorAddress(validatorAddr);

        Messages<MsgWithdrawValidatorCommissionValue> msg = new Messages<>();
        msg.setType(msgType);
        msg.setValue(value);
        Messages[] msgs = new Messages[1];
        msgs[0] = msg;
        return msgs;
    }

}
