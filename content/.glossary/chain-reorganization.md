---
title: Chain Reorganization
description: A situation where a node discovers that its local chain is not the canonical chain and switches over to the canonical chain
tags:
  - fundamental
---

Transactions are processed in a distributed manner. From time to time it can happen that a node produces a different chain of new blocks than other nodes. Effectively, the blockchain then has different branches. When this situation is detected through the consensus protocol, the branch with the most accumulated work is chosen as the canonical branch (hence representing the {{< glossary "canonical-truth" "canonical truth" >}} of the blockchain.

When a node discovers that its local version of the blockchain is not the canonical chain, it starts a local chain reorganization to switch over to the canonical chain.

On Ethereum, chain reorganization can even occur after hundreds of new blocks have been finalized. This can delay global consensus on the canonical truth for hours.