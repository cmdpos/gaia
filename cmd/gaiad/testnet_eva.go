package main


/*
nodeDirName: [node0]
clientDir: [cache/node0/gaiacli]
addr: [eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz]
secret: [depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper]

nodeDirName: [node1]
clientDir: [cache/node1/gaiacli]
addr: [eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6]
secret: [country live width exotic behind mad belt bachelor later outside forget rude pudding material orbit shoot kind curve endless prosper make exotic welcome maple]

nodeDirName: [node2]
clientDir: [cache/node2/gaiacli]
addr: [eva1ztwjutkmfk30q8jr8444fyenkvwzrt2nczmgmn]
secret: [name vendor rose aunt lady bunker success picture rapid grace height antique judge abuse apology teach usual kangaroo fossil glimpse series spread rail polar]

{
  "name": "node3",
  "type": "local",
  "address": "eva1jt9vwuyfqmtphd2g36gyxmrwaga4tgekukysyp",
  "pubkey": "evapub1addwnpepqt8w9l20fhupwh7gc2wetzta8np3msl5d75tl0y6cmefshfrapfwsq2kmlp",
  "mnemonic": "motor always goose dune card scrub transfer veteran trick immense eight enrich jewel left denial cool acid profit good siren negative leopard early mechanic"
}
{
  "name": "node4",
  "type": "local",
  "address": "eva1yt78l96damcpge2wkgy988znl9svg9vdalqnws",
  "pubkey": "evapub1addwnpepq2g0gpsrkk2e8xdz3rfxhlx2j5a29y3uflnrmjchw9drfpnc4snpkn27una",
  "mnemonic": "future useful vanish scorpion ugly certain oxygen magnet chuckle elite hip fault two race curious wheat dish puzzle brick addict coil prefer stone wife"
}
{
  "name": "node5",
  "type": "local",
  "address": "eva1hxtpykp4x8u99hqkq5mayea5tgdpehcxy4v2k5",
  "pubkey": "evapub1addwnpepq2zl7mmvuqnp3gft5sndfgzza8rg6xrqzs54glhphx87fjwpn6q676h20gk",
  "mnemonic": "clerk universe city game fortune kitchen arrive regret donor wide borrow typical hold harbor actor raise inside truly nation ethics rally layer arena clump"
}
{
  "name": "node6",
  "type": "local",
  "address": "eva12lsf9l7ycdzj4gvsnwwxcaetrpwgjvj29feurs",
  "pubkey": "evapub1addwnpepqfwd8gl27l9wh5tzg3xl9xlftrr5jxhhtuxjenwnpeed25tmrm42qtev0w7",
  "mnemonic": "great inflict undo exchange sunny zone squeeze staff gadget style still plastic swear decorate tray still minimum plate elephant destroy cheese best ring learn"
}
{
  "name": "node7",
  "type": "local",
  "address": "eva1cltn9xun2ttsycn0eurfhd9dmnn85j9yj938n9",
  "pubkey": "evapub1addwnpepqtn3s5t0h5s05x2d8vp0xnq8wn99232fj7z4k7tze2s8ck5yqgkncjf7us0",
  "mnemonic": "tree metal excess fossil forget donor thought blast diary can flee rabbit cage float virtual ball object elbow ski brush tag dash faculty oak"
}
{
  "name": "node8",
  "type": "local",
  "address": "eva1ltrmr03j0r43ts794pqyg4pzxnnrpxnmnkuk9l",
  "pubkey": "evapub1addwnpepqtk6vvnksx3pzkd9sz43hzk32ykdy07v284e774ag5eu23sqdw6jqlncfns",
  "mnemonic": "bring shuffle net tonight elder help bar picnic sheriff trick ketchup panel boil guard void market more lion friend sick absent lazy camera envelope"
}
{
  "name": "node9",
  "type": "local",
  "address": "eva1v7dsqqn8ayvsfaa25gxd6hw56s3vmz8hxk2t6x",
  "pubkey": "evapub1addwnpepqvl9ryga3ysq4usfc3dhsx9j006306qkqs7rc2juc528rrzwgtgqg5fcvqd",
  "mnemonic": "park argue normal rally oven bus later problem siren way grape destroy cherry asset royal place stage expand rate monitor squirrel make wasp drastic"
}
{
  "name": "node10",
  "type": "local",
  "address": "eva173sclfedjwgf64kwymw5qscmc6vjg97l05zrml",
  "pubkey": "evapub1addwnpepqtrq0celc0mauagyq65a2wrww68zd0afvrn9ydhzx4ltl0ek343xx5l4yp8",
  "mnemonic": "biology bike beauty goat critic know flat trap deny special year human case february staff vast kid science math hybrid trial napkin space security"
}

*/

var (
	testnetAccountList = []string{
		// eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz
		// 2c999c5afe7f0c902846e1b286fed29c5c5914998655d469568560955abe0d5d
		"depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper",

		// eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6
		"country live width exotic behind mad belt bachelor later outside forget rude pudding material orbit shoot kind curve endless prosper make exotic welcome maple",
		"name vendor rose aunt lady bunker success picture rapid grace height antique judge abuse apology teach usual kangaroo fossil glimpse series spread rail polar",
		"motor always goose dune card scrub transfer veteran trick immense eight enrich jewel left denial cool acid profit good siren negative leopard early mechanic",
		"future useful vanish scorpion ugly certain oxygen magnet chuckle elite hip fault two race curious wheat dish puzzle brick addict coil prefer stone wife",
		"clerk universe city game fortune kitchen arrive regret donor wide borrow typical hold harbor actor raise inside truly nation ethics rally layer arena clump",
		"great inflict undo exchange sunny zone squeeze staff gadget style still plastic swear decorate tray still minimum plate elephant destroy cheese best ring learn",
		"tree metal excess fossil forget donor thought blast diary can flee rabbit cage float virtual ball object elbow ski brush tag dash faculty oak",
		"bring shuffle net tonight elder help bar picnic sheriff trick ketchup panel boil guard void market more lion friend sick absent lazy camera envelope",
		"park argue normal rally oven bus later problem siren way grape destroy cherry asset royal place stage expand rate monitor squirrel make wasp drastic",
		"biology bike beauty goat critic know flat trap deny special year human case february staff vast kid science math hybrid trial napkin space security",
		//"",
		//"",
		//"",
		//"",
	}
)

func getTestnetMnemonic(index int) string {
	if len(testnetAccountList) - 1 < index {
		return ""
	}

	return testnetAccountList[index]
}
