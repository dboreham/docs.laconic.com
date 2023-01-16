---
title: Watcher
description: A custom cache of IPLD blocks that represent Ethereum blockchain data
tags:
  - fundamental
---

A Watcher is a program that creates custom caches of verified {{< glossary "blockchain" "blockchain" >}} data that is available as {{< glossary "ipld" "IPLD" >}} blocks. A Watcher queries, fetches, and caches data from the {{< glossary "laconic-stack" "Laconic Stack" >}} by subscribing via the {{< glossary "watcher-registry" "Watcher Registry" >}}.

Watchers are written in {{< glossary "typescript" "TypeScript" >}} and compiled to {{< glossary "wasm" "WASM" >}}. They can be written manually or be derived from a {{< glossary "smartcontract" "Smart Contract" >}}'s Solidity or Vyper source code.

Watchers are composable; that is, a Watcher can refer to data that was previously derived from the blockchain by another Watcher.
