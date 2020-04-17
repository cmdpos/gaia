package rest

import (
	"github.com/gorilla/mux"

	"github.com/cosmos/cosmos-sdk/client/context"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/rest"
)

func registerTxRoutes(cliCtx context.CLIContext, r *mux.Router) {

}

type (
	// DelegateRequest defines the properties of a delegation request's body.
	DelegateRequest struct {
		BaseReq          rest.BaseReq   `json:"base_req" yaml:"base_req"`
		DelegatorAddress sdk.AccAddress `json:"delegator_address" yaml:"delegator_address"` // in bech32
		ValidatorAddress sdk.ValAddress `json:"validator_address" yaml:"validator_address"` // in bech32
		Amount           sdk.Coin       `json:"amount" yaml:"amount"`
	}

	// RedelegateRequest defines the properties of a redelegate request's body.
	RedelegateRequest struct {
		BaseReq             rest.BaseReq   `json:"base_req" yaml:"base_req"`
		DelegatorAddress    sdk.AccAddress `json:"delegator_address" yaml:"delegator_address"`         // in bech32
		ValidatorSrcAddress sdk.ValAddress `json:"validator_src_address" yaml:"validator_src_address"` // in bech32
		ValidatorDstAddress sdk.ValAddress `json:"validator_dst_address" yaml:"validator_dst_address"` // in bech32
		Amount              sdk.Coin       `json:"amount" yaml:"amount"`
	}

	// UndelegateRequest defines the properties of a undelegate request's body.
	UndelegateRequest struct {
		BaseReq          rest.BaseReq   `json:"base_req" yaml:"base_req"`
		DelegatorAddress sdk.AccAddress `json:"delegator_address" yaml:"delegator_address"` // in bech32
		ValidatorAddress sdk.ValAddress `json:"validator_address" yaml:"validator_address"` // in bech32
		Amount           sdk.Coin       `json:"amount" yaml:"amount"`
	}
)

