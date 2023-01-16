---
title: Blockchain
description: A chain of cryptographically linked, immutable data blocks
tags:
  - fundamental
draft: true
---

A blockchain is a list of records, called blocks, that are linked together using cryptography, and are resistant to modification. Each new block added contains a cryptographic hash of the previous block, a timestamp, and transaction data (see also: Merkle Tree). The data in any given block cannot be altered retroactively without altering all subsequent blocks and thereby corrupting all subsequent hashes and altering their Merkle Tree.

When adding a block to a blockchain:
- **The cryptographic hash** proves the new block has been added to the previous state of the chain.
- **The timestamp** proves that the transaction data existed at the time of publication in order to get into its hash. 
- **All blocks contain information about (all the) the previous block(s);** the “chain” is reinforced with each new block added.
