---
title: Merkle Tree
description: A tree data structure used for verification of content
tags:
  - fundamental
---

In cryptography and computer science, a hash tree or “Merkle Tree” (named after Ralph Merkle, who patented it in 1979) allows efficient and secure verification of the contents of a large data structure. This verification is essential to “trustless” decentralized systems (see also: Trustless Systems, below).

In a Merkle Tree, every “leaf” data note is labeled with the cryptographic hash of the data (e.g., files or assets) attached to the node. Every “branch” node (nodes that aren’t leaves) is labeled with the cryptographic hash of the labels of its child nodes. Nodes farther up in the tree are the hashes of their respective children.

