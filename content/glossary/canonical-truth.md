---
title: Canonical Truth
description: The authoritative state of a distributed system, established by consensus among all involved parties
tags:
  - fundamental
draft: true
---

In a distributed system, data updates must eventually get synchronized across all nodes. Until this happens, different parts of the system may apply different, perhaps incompatible, updates to the system. Canonical Truth is established once all data is in sync again and all parts of the system have reached consensus upon the state of the system.

In a blockchain context, it can happen that the list of newly validated blocks diverges between two segments of the system, causing the chain to fork into separate branches. A distributed consensus mechanism ensures that the blockchain eventually reaches a globally consistent state again, where the branch that accumulated most of the work "wins" and henceforth represents the canonical truth. Nodes that have been creating a different branch then need to do a local in order to switch to the canonical chain.


