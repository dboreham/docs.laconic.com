---
title: devp2p
description: A set of network protocols that form the Ethereum peer-to-peer network
tags:
  - fundamental
---

`devp2p` is a set of network protocols of various levels and purposes. Together, they form Ethereum's peer-to-peer network. 

On a lower level, `devp2p` consists of a node records data format, a node discovery protocol, and the RLPx transport protocol (based on TCP). 

On application level, `devp2p` provides the Ethereum Wire Protocol for exchanging blockchain information, the Ethereum Snapshot Protocol for exchanging state snapshots, the Light Ethereum Subprotocol for so-called light clients and a variation of it called Parity Light Protocol, and the Ethereum Witness Protocol for exchanging state witnesses.




