---
title: IPFS
description: InterPlanetary File System, a protocol and p2p-network for storing and sharing data
tags:
  - fundamental
---

The InterPlanetary File System (IPFS) is a distributed system for storing and accessing files. It builds upon a {{< glossary "contentaddressing" "content-addressable" >}}, distributed data structure and a peer-to-peer protocol for sharing content without centralized structures. 

Content is immutable. When content is updated, IPFS generates a new content address while the old content address remains available. 

Content is public by default. Knowledge of a Content Identifier (CID) is sufficient for retrieving the content the CID points to. 

To ensure that IPFS content remains available to others, participants in the IPFS network can collaborate with each other to agree on "pinning" their content mutually, so their IPFS nodes will continue serving that content. Pinning services offer the same on a commercial basis.

IPFS is built on top of a number of concepts and technologies, including {{< glossary "ipld" "IPLD" >}}, peer-to-peer protocols, and data storage.
