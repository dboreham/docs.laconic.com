---
title: "Quick Start"
date: 2022-12-30T09:19:28-05:00
draft: false
weight: 1
---

This tutorial will give you an overview of some key components of the Laconic Stack. You will accomplish the following:

- stand up the core stack
- deploy an ERC20 watcher
- deploy an ERC20 token
- send tokens to and from your local account to another account on Metamask
- use GraphQL to query the watcher for information about the token and accounts.

It is an extension of [this demo](https://github.com/cerc-io/stack-orchestrator/tree/main/stacks/erc20)

## Install

- clone the stack orchestrator repository:

```
git clone https://github.com/cerc-io/stack-orchestrator.git
```

Make the root of that repo your current working directory:
```
cd stack-orchestrator
```

- download the `laconic-so` binary

```
curl -L -o laconic-so https://github.com/cerc-io/stack-orchestrator/releases/download/v1.0.5-alpha/laconic-so
chmod +x laconic-so
```

For a more permanent setup, move the binary to `~/bin` and add it your `PATH`.

The `laconic-so` binary also requires:

- `python3` [Install](https://www.python.org/downloads/)
- `docker` [Install](https://docs.docker.com/get-docker/)
- `docker-compose` [Install](https://docs.docker.com/compose/install/)

If using a fresh Linux droplet, check out [this script](https://github.com/LaconicNetwork/Laconic-Documentation/blob/main/scripts/install-laconic-stack.sh) for a quick setup.

**WARNING**: if installing docker-compose via package manager (as opposed to Docker Desktop), you must install the plugin, e.g., on Linux:

```
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
```

Finally, [install MetaMask](link) in the supported browser of your choice.

## Stack Orchestrator

The `laconic-so` CLI tool makes it easy to experiment with various components of the stack. It allows you to quickly and seamlessly experiment with watchers. Because it uses docker/docker-compose, several commands in this tutorial will leverage the ability to execute commands directely in the containers. This, for example, means that `yarn` doesn't need to be installed on your local machine.

## Setup

Use the stack orchestrator to pull the core repositories:

```
./laconic-so setup-repositories --include cerc-io/go-ethereum,cerc-io/ipld-eth-db,cerc-io/ipld-eth-server,cerc-io/watcher-ts --pull
```

You'll see something like:
```
Dev Root is: /root/cerc
Dev root directory doesn't exist, creating
Excluding: vulcanize/ops
Excluding: cerc-io/eth-statediff-service
Excluding: vulcanize/eth-statediff-fill-service
Excluding: vulcanize/ipld-eth-db-validator
Excluding: vulcanize/ipld-eth-beacon-indexer
Excluding: vulcanize/ipld-eth-beacon-db
Excluding: cerc-io/laconicd
Excluding: cerc-io/laconic-cns-cli
Excluding: cerc-io/mobymask-watcher
Excluding: vulcanize/assemblyscript
Checking: /root/cerc/ipld-eth-db: Needs to be fetched
100%|###################################################################################################################| 595/595 [00:00<00:00, 797B/s]
Checking: /root/cerc/go-ethereum: Needs to be fetched
100%|#############################################################################################################| 71.5k/71.5k [00:19<00:00, 3.65kB/s]
Checking: /root/cerc/ipld-eth-server: Needs to be fetched
100%|#############################################################################################################| 25.5k/25.5k [00:06<00:00, 3.93kB/s]
Checking: /root/cerc/watcher-ts: Needs to be fetched
100%|#############################################################################################################| 8.41k/8.41k [00:01<00:00, 8.08kB/s]
```

Next, we'll build the docker images for each repo we just fetched.

```
./laconic-so build-containers --include cerc/go-ethereum,cerc/go-ethereum-foundry,cerc/ipld-eth-db,cerc/ipld-eth-server,cerc/watcher-erc20
```

This process will take 10-15 minutes, go make a pot of coffee.

TODO what is the success message

Next, let's deploy this stack:

```
./laconic-so deploy-system --include db,go-ethereum-foundry,ipld-eth-server,watcher-erc20 up
```

The end of the output will look something like:

```
[+] Running 5/5
 ⠿ Network laconic-0aa2a222529cdb7b0bfcc4c0f5766074_default              Created                                                                  0.2s
 ⠿ Container laconic-0aa2a222529cdb7b0bfcc4c0f5766074-ipld-eth-db-1      He...                                                                   32.2s
 ⠿ Container laconic-0aa2a222529cdb7b0bfcc4c0f5766074-migrations-1       Sta...                                                                  32.7s
 ⠿ Container laconic-0aa2a222529cdb7b0bfcc4c0f5766074-go-ethereum-1      St...                                                                   32.7s
 ⠿ Container laconic-0aa2a222529cdb7b0bfcc4c0f5766074-ipld-eth-server-1  Started                                                                 32.7s
```

Let's take stock of what just happened, we:
- cloned a bunch of repos: `laconic-so setup-repositories`
- built all of their docker images: `laconic-so build-containers`
- deployed these images as services that know about each other: `laconic-so deploy-system up`

Take a look at all the running docker containers:

```
docker ps
```

You should see 6 containers:

```
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                    PORTS                                            NAMES
375781e8ea51   cerc/watcher-erc20:local           "docker-entrypoint.s…"   14 minutes ago   Up 13 minutes (healthy)   0.0.0.0:3001->3001/tcp, 0.0.0.0:9001->9001/tcp   laconic-515b4020f964b70ab3826351cd3f9eb5-erc20-watcher-1
57fddbabafd7   cerc/ipld-eth-server:local         "/app/entrypoint.sh"     14 minutes ago   Up 14 minutes (healthy)   127.0.0.1:8081-8082->8081-8082/tcp               laconic-515b4020f964b70ab3826351cd3f9eb5-ipld-eth-server-1
32960ff93da5   cerc/go-ethereum-foundry:local     "./start-private-net…"   14 minutes ago   Up 14 minutes (healthy)   127.0.0.1:8545-8546->8545-8546/tcp               laconic-515b4020f964b70ab3826351cd3f9eb5-go-ethereum-1
667f64fe6f0a   cerc/ipld-eth-db:local             "/app/startup_script…"   14 minutes ago   Up 14 minutes                                                              laconic-515b4020f964b70ab3826351cd3f9eb5-migrations-1
61da438e8a2f   postgres:14-alpine                 "docker-entrypoint.s…"   14 minutes ago   Up 14 minutes (healthy)   0.0.0.0:15432->5432/tcp                          laconic-515b4020f964b70ab3826351cd3f9eb5-watcher-db-1
4458135e10d7   timescale/timescaledb:2.8.1-pg14   "docker-entrypoint.s…"   14 minutes ago   Up 14 minutes (healthy)   127.0.0.1:8077->5432/tcp                         laconic-515b4020f964b70ab3826351cd3f9eb5-ipld-eth-db-1
```

Let's go through them 1-by-1:

- watcher-erc20: does X and we'll be using its `CONTAINER_ID` later on.
- ipld-eth-server:
- go-ethereum-foundry:
- ipld-eth-db: the database schema for ipld-eth-server
- postgres:
- timescaledb:

Finally, via the `watcher-erc20` container, the [GraphQL](link) playground is enabled on `http://localhost:3001/graphql` and you should check that it is there:

[img](link)

Great so now we have the core stack up and running, let's deploy an ERC20 token.

First, we need the `CONTAINER ID` of the ERC20 watcher:
```
docker ps | grep "watcher-erc20"
```

Using the `ID` from the example above, we'll export the `CONTAINER_ID` for use throughout the rest of the tutorial:

```
export CONTAINER_ID=375781e8ea51
```

Next, we can deploy an ERC20 token (currency symbol GLD):
```
docker exec $CONTAINER_ID yarn token:deploy:docker
```

and your output should look like:
```
yarn run v1.22.19
$ hardhat --network docker token-deploy
Downloading compiler 0.8.0
Compiled 5 Solidity files successfully
GLD Token deployed to: 0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550
Deployed at block: 9087 0x4dc63b4b2695b644d7d390d70c9de0232399ea4d54b8c75911eee14c13f9ceaf
Done in 157.39s.
```

Great, now that we've deployed the GLD token, you'll want to export its address for later use:

```
export TOKEN_ADDRESS=0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550
```

Get your primary account address with:
```
docker exec $CONTAINER_ID yarn account:docker
```
and the following output:
```
yarn run v1.22.19
$ hardhat --network docker account
0x33AF7AB219be47367dfa5A3739e6B9CA1c40cDC8
Done in 21.63s.
```

export that address to your shell:
```
export PRIMARY_ADDRESS=0x33AF7AB219be47367dfa5A3739e6B9CA1c40cDC8
```

(where is the priv-key or mnemonic for this account?)

To get the latest block hash at any time, run:
```
docker exec $CONTAINER_ID yarn block:latest:docker
```

for an output like:
```
yarn run v1.22.19
$ hardhat --network docker block-latest
Block Number: 12783
Block Hash: 0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75
Done in 21.44s.
```

Since you'll need the latest block hash a few times later in this tutorial, create an alias:
```
alias latest-bh="docker exec $CONTAINER_ID yarn block:latest:docker
```

Next we'll configure MetaMask.

## MetaMask

Open MetaMask in your browser:

1. Click "Add Network"

![MetaMask Add Network](/images/mm-add-network.png)

2. Scroll to the bottow and click "Add Network Manually"

![MM Add Network Manually](/images/mm-add-network-manually.png)

3. Put in this information:

![MM Add Network Manually Localhost](/images/mm-add-network-manually-localhost.png)
If you see the error above "This URL is currently used by the Localhost 8545 Network", either:

change `localhost` to `127.0.0.1`
![MM Add Network Manually 127](/images/mm-add-network-manually-127.png)

We will come back to MetaMask later and complete this process; for now, copy your new address

![MM Copy Address 2](/images/mm-copy-address-2.png)
and export it for later:
```
export RECIPIENT_ADDRESS=0x988a070c97D33a9Dfcc134df5628b77e8B5214ad
```

## GraphQL

Head on over to [http://localhost:3001/graphql](http://localhost:3001/graphql) and paste the following (but with your variables):

```
query {
  name(
    blockHash: "0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75"
    token: "0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550"
  ) {
    value
    proof {
      data
    }
  }

  symbol(
    blockHash: "0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75"
    token: "0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550"
  ) {
    value
    proof {
      data
    }
  }

  totalSupply(
    blockHash: "0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75"
    token: "0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550"
  ) {
    value
    proof {
      data
    }
  }
}
```

and you'll see a response like this:
```
{
  "data": {
    "name": {
      "value": "Gold",
      "proof": {
        "data": "[{\"blockHash\":\"0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzavwb52aq6smf6movgcimvuoggp3cifayb2vyidg3ar546pwtb3dea\",\"ipldBlock\":\"0xf843a032575a0e9e593c00f959f8c92f12db2869c3395a3b0502d05e2516446f71f85ba1a0476f6c6400000000000000000000000000000000000000000000000000000008\"}}}]"
      }
    },
    "symbol": {
      "value": "GLD",
      "proof": {
        "data": "[{\"blockHash\":\"0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzanp5bxcn6wqd2yptbbwo5o4rx3mhpji43yd7sfd42suq6hjuhuroq\",\"ipldBlock\":\"0xf843a03a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19ba1a0474c440000000000000000000000000000000000000000000000000000000006\"}}}]"
      }
    },
    "totalSupply": {
      "value": "1000000000000000000000",
      "proof": {
        "data": "{\"blockHash\":\"0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzasfla7wzuessejihdtrxqd5lqxc57egukbbricizz2ssrltex4uvq\",\"ipldBlock\":\"0xeca0305787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace8a893635c9adc5dea00000\"}}}"
      }
    }
  }
}
```

Here's what it'll look like in the browser:

![GQL Token Query](/images/graphql-token-query.png)

A lot has happened thus far, so let's review; we've:
- downloaded the core repos, built their docker images, and launched a local network (all using stack orchestrator)
- deployed an ERC20 token, added it to our MetaMask account
- used the GraphQL playground to query the ERC20 watcher
- exported a handful of shell variables which are about to come in handy

Next we'll use the playground to query account balances:
```
query {
  fromBalanceOf: balanceOf(
      # latest block hash
      blockHash: "0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75"
      token: "0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550"
      # primary account having all the balance initially
      # created by stack orchestrator
      owner: "0x33AF7AB219be47367dfa5A3739e6B9CA1c40cDC8"
    ) {
    value
    proof {
      data
    }
  }
  toBalanceOf: balanceOf(
      blockHash: "0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75"
      token: "0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550"
      # address copied from MetaMask, has no balance initially
      owner: "0x988a070c97D33a9Dfcc134df5628b77e8B5214ad"
    ) {
    value
    proof {
      data
    }
  }
}
```
the primary address should have `value` 1000000000000000000000 and the recipient address should have 0:

```
{
  "data": {
    "fromBalanceOf": {
      "value": "1000000000000000000000",
      "proof": {
        "data": "{\"blockHash\":\"0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzarsopkngjoijjyktfhgckq7te4dsk25gfyj653uxu4kcwqoyuykiq\",\"ipldBlock\":\"0xeca031bcbb6b5a44c97488b8904a85b2396b1cf337ff3ee4efb0ea1ef5104325dbfc8a893635c9adc5dea00000\"}}}"
      }
    },
    "toBalanceOf": {
      "value": "0",
      "proof": {
        "data": "{\"blockHash\":\"0xb7b4b65dd5fe3800a6c38cb8a26249bbb82041d7e0b347a853b73efc7a473b75\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"\",\"ipldBlock\":\"0x\"}}}"
      }
    }
  }
}
```

Note also that the recipient address also does not yet have a `cid` or `ipldBlock`, which makes sense; this is a random account we just created and hasn't received any transactions. The network does not know about it.

Let's send it some GLD!

```
docker exec $CONTAINER_ID yarn token:transfer:docker --token $TOKEN_ADDRESS --to $RECIPIENT_ADDRESS --amount 100000000 
```

You'll see a familiar output:
```
yarn run v1.22.19
$ hardhat --network docker token-transfer --token 0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550 --to 0x988a070c97D33a9Dfcc134df5628b77e8B5214ad --amount 100000000
Nothing to compile
Transfer Event at block: 13371 0x412dbc25599773bfe929c67882e4a001b9d1b3b8e1c60ad4a495d5306608c77a
from: 0x33AF7AB219be47367dfa5A3739e6B9CA1c40cDC8
to: 0x988a070c97D33a9Dfcc134df5628b77e8B5214ad
value: 100000000
Done in 26.12s.
```

Now get the latest block height using the `latest-bh` alias, or for a refresher:
```
docker exec $CONTAINER_ID yarn block:latest:docker 
```

and go back to the GraphQL playground. If you've changed nothing since the last query, update only the latest block hash and run the query again, you'll see the updated account balances:

```
{
  "data": {
    "fromBalanceOf": {
      "value": "999999999999900000000",
      "proof": {
        "data": "{\"blockHash\":\"0xec173c3aac86a533710569340a4ffb3f3e2d46080e35b034e93ec0049cc12174\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzahg5shtf2rr7pompx7yx6r22zu4lea7ftlnbqkqcabvndsrvoljhq\",\"ipldBlock\":\"0xeca031bcbb6b5a44c97488b8904a85b2396b1cf337ff3ee4efb0ea1ef5104325dbfc8a893635c9adc5d8aa1f00\"}}}"
      }
    },
    "toBalanceOf": {
      "value": "100000000",
      "proof": {
        "data": "{\"blockHash\":\"0xec173c3aac86a533710569340a4ffb3f3e2d46080e35b034e93ec0049cc12174\",\"account\":{\"address\":\"0x0Dcb65938A483547835e2ebB4FC6cBf7AEe77550\",\"storage\":{\"cid\":\"bagmacgzas6xotntgq4u3v4eui6pmtbyttgikzmu7mppknam2wrekhoynupjq\",\"ipldBlock\":\"0xe7a03305adb1a8efab310b21e03d5a9f08d8cf98815372c2c4d8068e1359b8f996bc858405f5e100\"}}}"
      }
    }
  }
}
```

Great, you've now used a watcher to see query token balances.

Let's send some tokens from the MetaMask recipient account back to the primary account.

Recall that when adding the network to MetaMask, we used the currency symbol "GLD". However, this does not mean that MetaMask can auto-detect the token, therefore, we will have to manually import it:

![MM Import Tokens](/images/mm-import-tokens.png)

Copy the `TOKEN_ADDRESS` and paste it in the popup. The two other fields should auto-complete:

![MM Import Tokens 2](/images/mm-import-tokens-2.png)

Click "Import Token"

![MM Import Tokens 3](/images/mm-import-tokens-3.png)

and now you'll see your balance. Ignore the GLD token from earlier.

![MM GLD Imported](/images/mm-gld-imported.png)

Finally, send some tokens back to the primary address using MetaMask:

![MM Insuff Funds](/images/mm-send-tokens-insuff-funds.png)

Make the gas price `0`:

![MM Send No Gas](/images/mm-send-no-gas.png)

Grab the latest block hash (again) and fire off the GraphQL query for account balances to see the change.

Voila! You've successfully stood up the core Laconic stack, deployed an ERC20 token, and queried account balances.

Tear down your docker containers with:

```
./laconic-so deploy-system --include db,go-ethereum-foundry,ipld-eth-server,watcher-erc20 down
```

## Next steps



