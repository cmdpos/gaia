package types

import (
	"encoding/json"

	sdk "github.com/cosmos/cosmos-sdk/types"
)

// ensure Msg interface compliance at compile time
var (
	_ sdk.Msg = &MsgTokenBurn{}
)

type MsgTokenBurn struct {
	Amount sdk.Coins      `json:"amount"`
	Owner  sdk.AccAddress `json:"owner"`
}

func NewMsgTokenBurn(amount sdk.Coins, owner sdk.AccAddress) MsgTokenBurn {
	return MsgTokenBurn{
		Amount: amount,
		Owner:  owner,
	}
}

func (msg MsgTokenBurn) Route() string { return "token" }

func (msg MsgTokenBurn) Type() string { return "burn" }

func (msg MsgTokenBurn) ValidateBasic() sdk.Error {
	// check owner
	if msg.Owner.Empty() {
		return sdk.ErrInvalidAddress(msg.Owner.String())
	}

	if !msg.Amount.IsValid() {
		return sdk.ErrInvalidCoins("amount is invalid: " + msg.Amount.String())
	}
	if !msg.Amount.IsAllPositive() {
		return sdk.ErrInsufficientCoins("amount must be positive")
	}
	return nil
}

// GetSignBytes Implements Msg.
func (msg MsgTokenBurn) GetSignBytes() []byte {
	b, err := json.Marshal(msg)
	if err != nil {
		panic(err)
	}
	return sdk.MustSortJSON(b)
}

// GetSigners Implements Msg.
func (msg MsgTokenBurn) GetSigners() []sdk.AccAddress {
	return []sdk.AccAddress{msg.Owner}
}

