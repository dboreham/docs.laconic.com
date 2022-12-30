---
title: Merkleization
description: To compute a Merkle tree on the fly from given leaves
tags:
  - fundamental
  - ethereum
---

Merkleization is a technique for computing a [Merkle tree]({{< relref merkletree >}}) from existing data without storing the entire tree structure in memory or on disk. The result of a Merkleization is the root hash of the Merkle tree. 

In {{< glossary "ethereum" "Ethereum" >}} context, Merkleization is used for proving that a given transaction is part of the state trie whose root hash is included in a given block header.


See also: 

[Merkleization | Upgrading Ethereum](https://eth2book.info/altair/part2/building_blocks/merkleization/#merkleization)

[EIP-2926: Chunk-Based Code Merkleization](https://eips.ethereum.org/EIPS/eip-2926)

[The Burden of Proof(s): Code Merkleization | Ethereum Foundation Blog](https://blog.ethereum.org/2020/11/30/the-1x-files-code-merkleization/)

[Merkling in Ethereum | Ethereum Foundation Blog](https://blog.ethereum.org/2015/11/15/merkling-in-ethereum/)
