---
title: EVM (Ethereum Virtual Machine)
description: A virtual machine for executing bytecode
tags:
  - fundamental
---

The Ethereum Virtual Machine (EVM) is the runtime environment of Ethereum for executing transactions and {{< glossary "smartcontract" "Smart Contract" >}} code called by a transaction. 

The EVM runs on Ethereum nodes (that is, participants in the Ethereum network) in an isolated environment to ensure that every node produces the same output for the same input and transaction execution, thus enabling network consensus. Therefore, the EVM can also be viewed as a single computer whose state is shared among Ethereum nodes.

Technically, the EVM is a stack-based virtual machine for executing arbitrary code. A virtual machine is an abstraction layer on top of the actual CPU, which allows writing portable code that runs on different hardware.

The EVM is Turing-complete, which means it is theoretically capable of performing all tasks that computers can accomplish (but limited by available memory). In other words, it has no artificial limitations like the lack of loops or other fundamental mechanisms.

A number of programming languages exist that specifically compile to EVM bytecode, including {{< glossary "solidity" "Solidity" >}}, Vyper, or LLL. 

Various implementations of the EVM exist in different programming languages. Laconic supports Smart Contracts written in the Solidity programming language.
