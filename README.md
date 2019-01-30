# Okchain

Copyright (c) 2018-2019 The Okchain Project.
Portions Copyright (c) 2012-2013 The Cryptonote developers.

## Development resources

- Web: [okcoin.com/chain](https://www.okcoin.com/chain)
- Forum: [forum.okchain.org](https://forum.okchain.org)
- Mail: [dev@okcoin.com](mailto:dev@okcoin.com)
- GitHub: [https://github.com/ok-chain/okchain](https://github.com/okchain-project/okchain)

## Vulnerability response

- Our [Vulnerability Response Process](https://github.com/okchain-project/meta/blob/master/VULNERABILITY_RESPONSE_PROCESS.md) encourages responsible disclosure
- We are also available via [HackerOne](https://hackerone.com/okchain)

## Build

| Operating System      | Processor | Status |
| --------------------- | -------- |--------|
| Ubuntu 16.04          |  amd64   | [![Ubuntu 16.04 amd64](https://build.okchain.org/png?builder=Okchain-static-ubuntu-amd64)](https://build.okchain.org/builders/okchain-static-ubuntu-amd64)
| OSX 10.13             |  amd64   | [![OSX 10.12 amd64](https://build.okchain.org/png?builder=Okchain-static-osx-10.12)](https://build.okchain.org/builders/okchain-static-osx-10.12)


## Introduction

Okchain is a private, secure, untraceable, decentralised digital currency. You are your bank, you control your funds, and nobody can trace your transfers unless you allow them to do so.

**Privacy:** Okchain uses a cryptographically sound system to allow you to send and receive funds without your transactions being easily revealed on the blockchain (the ledger of transactions that everyone has). This ensures that your purchases, receipts, and all transfers remain absolutely private by default.

**Security:** Using the power of a distributed peer-to-peer consensus network, every transaction on the network is cryptographically secured. Individual wallets have a 25 word mnemonic seed that is only displayed once, and can be written down to backup the wallet. Wallet files are encrypted with a passphrase to ensure they are useless if stolen.

**Untraceability:** By taking advantage of ring signatures, a special property of a certain type of cryptography, Okchain is able to ensure that transactions are not only untraceable, but have an optional measure of ambiguity that ensures that transactions cannot easily be tied back to an individual user or computer.

## About this project

This is the core implementation of Okchain. It is open source and completely free to use without restrictions, except for those specified in the license agreement below. There are no restrictions on anyone creating an alternative implementation of Okchain that uses the protocol and network in a compatible manner.

As with many development projects, the repository on Github is considered to be the "staging" area for the latest changes. Before changes are merged into that branch on the main repository, they are tested by individual developers in their own branches, submitted as a pull request, and then subsequently tested by contributors who focus on testing and code reviews. That having been said, the repository should be carefully considered before using it in a production environment, unless there is a patch in the repository for a particular show-stopping issue you are experiencing. It is generally a better idea to use a tagged release for stability.

**Anyone is welcome to contribute to Okchain's codebase!** If you have a fix or code change, feel free to submit it as a pull request directly to the "master" branch. In cases where the change is relatively small or does not affect other parts of the codebase it may be merged in immediately by any one of the collaborators. On the other hand, if the change is particularly large or complex, it is expected that it will be discussed at length either well in advance of the pull request being submitted, or even directly on the pull request.

## License

See [LICENSE](LICENSE).

## Contributing

If you want to help out, see [CONTRIBUTING](CONTRIBUTING.md) for a set of guidelines.

## Installing Okchain from a package

Packages are available for

* Ubuntu and [snap supported](https://snapcraft.io/docs/core/install) systems, via a community contributed build.

    snap install Okchain --beta

Installing a snap is very quick. Snaps are secure. They are isolated with all of their dependencies. Snaps also auto update when a new version is released.

* OS X via [Homebrew](http://brew.sh)

        brew tap sammy007/cryptonight
        brew install Okchain --build-from-source

* Docker

        # Build using all available cores
        docker build -t Okchain .

        # or build using a specific number of cores (reduce RAM requirement)
        docker build --build-arg NPROC=1 -t Okchain .

        # either run in foreground
        docker run -it -v /okchain/chain:/root/.bitOkchain -v /okchain/wallet:/wallet -p 18080:18080 Okchain

        # or in background
        docker run -it -d -v /okchain/chain:/root/.bitOkchain -v /okchain/wallet:/wallet -p 18080:18080 Okchain

Packaging for your favorite distribution would be a welcome contribution!

## Compiling Okchain from source

### Dependencies

The following table summarizes the tools and libraries required to build. A
few of the libraries are also included in this repository (marked as
"Vendored"). By default, the build uses the library installed on the system,
and ignores the vendored sources. However, if no library is found installed on
the system, then the vendored source will be built and used. The vendored
sources are also used for statically-linked builds because distribution
packages often include only shared library binaries (`.so`) but not static
library archives (`.a`).

| Dep          | Min. version  | Vendored | Debian/Ubuntu pkg  | Arch pkg     | Fedora            | Optional | Purpose        |
| ------------ | ------------- | -------- | ------------------ | ------------ | ----------------- | -------- | -------------- |
| GCC          | 4.7.3         | NO       | `build-essential`  | `base-devel` | `gcc`             | NO       |                |
| CMake        | 3.0.0         | NO       | `cmake`            | `cmake`      | `cmake`           | NO       |                |
| pkg-config   | any           | NO       | `pkg-config`       | `base-devel` | `pkgconf`         | NO       |                |
| Boost        | 1.58          | NO       | `libboost-all-dev` | `boost`      | `boost-devel`     | NO       | C++ libraries  |
| OpenSSL      | basically any | NO       | `libssl-dev`       | `openssl`    | `openssl-devel`   | NO       | sha256 sum     |

### Build instructions

Okchain uses the CMake build system and a top-level [Makefile](Makefile) that
invokes cmake commands as needed.

#### On Linux and OS X

* Install the dependencies
* Change to the root of the source code directory and build:

        cd okchain
        make

* The resulting executables can be found in `build/release/bin`

* Add `PATH="$PATH:$HOME/okchain/build/release/bin"` to `.profile`

* Run Okchain with `Okchaind --detach`


## Running Okchaind

The build places the binary in `bin/` sub-directory within the build directory
from which cmake was invoked (repository root by default). To run in
foreground:

    ./bin/okchaind

To list all available options, run `./bin/okchaind --help`.  Options can be
specified either on the command line or in a configuration file passed by the
`--config-file` argument.  To specify an option in the configuration file, add
a line with the syntax `argumentname=value`, where `argumentname` is the name
of the argument without the leading dashes, for example `log-level=1`.

To run in background:

    ./bin/okchaind --log-file Okchaind.log --detach

To run as a systemd service, copy
[Okchaind.service](utils/systemd/okchaind.service) to `/etc/systemd/system/` and
[Okchaind.conf](utils/conf/okchaind.conf) to `/etc/`. The [example
service](utils/systemd/okchaind.service) assumes that the user `Okchain` exists
and its home is the data directory specified in the [example
config](utils/conf/okchaind.conf).


### LMDB

Instructions for debugging suspected blockchain corruption as per @HYC

There is an `mdb_stat` command in the LMDB source that can print statistics about the database but it's not routinely built. This can be built with the following command:

`cd ~/okchain/external/db_drivers/liblmdb && make`

The output of `mdb_stat -ea <path to blockchain dir>` will indicate inconsistencies in the blocks, block_heights and block_info table.

The output of `mdb_dump -s blocks <path to blockchain dir>` and `mdb_dump -s block_info <path to blockchain dir>` is useful for indicating whether blocks and block_info contain the same keys.

These records are dumped as hex data, where the first line is the key and the second line is the data.



The Okchain software supports the following environments:
* Ubuntu 16.04 (Ubuntu 16.10 recommended)
* MacOS Darwin 10.12 and higher (MacOS 10.13.x recommended)


Environments will be supported in 2019 Q2:
* Windows
* Centos 7