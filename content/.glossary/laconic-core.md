---
title: Laconic Core
description: A system for making data from the Ethereum devp2p network available as IPLD blocks
tags:
  - fundamental
---

The Laconic Core is a system comprised of {{< glossary "laconic-geth" "`laconic-geth`" >}}, PostgreSQL, and `ipld-eth-server`. Laconic Core takes data from the Ethereum {{< glossary "devp2p" "`devp2p`" >}} network and makes it available as IPLD blocks stored in a PostgreSQL database. {{< glossary "watcher" "Watchers" >}} can then query this data to populate their local caches.

