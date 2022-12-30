---
title: Contract Slot
description: A 32-byte wide storage for smart contract data
tags:
  - fundamental
  - ethereum
---

On Ethereum, a contract slot is a 32-byte wide unit of storage for {{< glossary "smartcontract" "smart contracts" >}}. Variables are stored in the sequence in which they appear in the contract's source code. The compiler may pack multiple contiguous variables smaller than 32 bytes into a single 32-byte slot. Mappings and dynamic arrays cannot be stored between regular variables. Rather, a 32-byte hash value is stored there instead of the mapping or array. The hash value represents the address of the slot where the actual mapping or array starts.

Due to these storage rules, finding data can become rather costly, both in terms of time and gas to be spent. 

When the source code of a contract is available, data retrieval can become much easier by generating the storage layout from the source code. {{< glossary "watcher" "Watchers" >}} can make use of this to efficiently retrieve data from contract slots.

