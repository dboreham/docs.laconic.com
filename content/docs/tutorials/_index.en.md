---
title: "Quick start tutorial; standup the stack and deploy an ERC20 watcher"
description: "Use the Laconic Stack Orchestrator to deploy & query an ERC20 watcher locally"
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

# make the root of this repo your current working directory
cd stack-orchestrator
```

- download the `laconic-so` binary

```
curl -L -o laconic-so https://github.com/cerc-io/stack-orchestrator/releases/download/v1.0.3-alpha/laconic-so
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

TODO - also what's timescale db for, it's operationally awkward that erc20 also spun up postgres. Where did timescaledb come from and why do I need it?
....
Finally, via the `watcher-erc20` container, the [GraphQL](link) playground is enabled on `http://localhost:3002/graphql` and you should check that it is there:

[img](link)

Great so now we have the core stack up and running, let's deploy an ERC20 token.


## Next steps

