package token

import (
	"encoding/json"

	"github.com/gorilla/mux"
	"github.com/spf13/cobra"

	abci "github.com/tendermint/tendermint/abci/types"

	"github.com/cosmos/cosmos-sdk/client/context"
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/module"
	"github.com/cosmos/cosmos-sdk/x/token/client/cli"
	"github.com/cosmos/cosmos-sdk/x/token/client/rest"
	"github.com/cosmos/cosmos-sdk/x/token/types"
)

var (
	_ module.AppModule      = AppModule{}
	_ module.AppModuleBasic = AppModuleBasic{}
)

// app module basics object
type AppModuleBasic struct{}

var _ module.AppModuleBasic = AppModuleBasic{}

// module name
func (AppModuleBasic) Name() string {
	return ModuleName
}

// register module codec
func (AppModuleBasic) RegisterCodec(cdc *codec.Codec) {
	RegisterCodec(cdc)
}
// DefaultGenesis returns nil
func (AppModuleBasic) DefaultGenesis() json.RawMessage {
	return nil
}

// ValidateGenesis  Validation check of the Genesis
func (AppModuleBasic) ValidateGenesis(bz json.RawMessage) error {
	return nil
}


// register rest routes
func (AppModuleBasic) RegisterRESTRoutes(ctx context.CLIContext, rtr *mux.Router) {
	rest.RegisterRoutes(ctx, rtr)
}

// get the root tx command of this module
func (AppModuleBasic) GetTxCmd(cdc *codec.Codec) *cobra.Command {
	return cli.GetTxCmd(StoreKey, cdc)
}

// get the root query command of this module
func (AppModuleBasic) GetQueryCmd(cdc *codec.Codec) *cobra.Command {
	return cli.GetQueryCmd(StoreKey, cdc)
}


// app module
type AppModule struct {
	AppModuleBasic
	keeper       Keeper
	accKeeper    types.AccountKeeper
	supplyKeeper types.SupplyKeeper
}

// NewAppModule creates a new AppModule object
func NewAppModule(keeper Keeper, accKeeper types.AccountKeeper,
	supplyKeeper types.SupplyKeeper) AppModule {

	return AppModule{
		AppModuleBasic: AppModuleBasic{},
		keeper:         keeper,
		accKeeper:      accKeeper,
		supplyKeeper:   supplyKeeper,
	}
}

// module name
func (AppModule) Name() string {
	return ModuleName
}

// register invariants
func (am AppModule) RegisterInvariants(ir sdk.InvariantRegistry) {
	//RegisterInvariants(ir, am.keeper)
}

// module message route name
func (AppModule) Route() string {
	return RouterKey
}

// module handler
func (am AppModule) NewHandler() sdk.Handler {
	return NewHandler(am.keeper)
}

// module querier route name
func (AppModule) QuerierRoute() string {
	return QuerierRoute
}

// module querier
func (am AppModule) NewQuerierHandler() sdk.Querier {
	return NewQuerier(am.keeper)
}
// InitGenesis initialize module genesis
func (am AppModule) InitGenesis(ctx sdk.Context, data json.RawMessage) []abci.ValidatorUpdate {
	return nil
}

// ExportGenesis exports module genesis
func (am AppModule) ExportGenesis(ctx sdk.Context) json.RawMessage {
	return nil
}

// module begin-block
func (AppModule) BeginBlock(_ sdk.Context, _ abci.RequestBeginBlock) {}

// module end-block
func (am AppModule) EndBlock(ctx sdk.Context, _ abci.RequestEndBlock) []abci.ValidatorUpdate {
	return EndBlocker(ctx, am.keeper)
}
