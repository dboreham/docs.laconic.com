---
title: Content Addressing
description: A technique of addressing data by content rather than location
tags:
  - fundamental
---

Content Addressing is a way of making data available through a globally unique content identifier (CID), rather than pointing to a specific location where the data is stored.

The content identifier (CID) is usually a cryptographic hash value created from the content. If the content changes, so does the CID. 

Advantages of content addressing:

- Content addressing avoids link rot. Re-organizing content in Web1/Web2 may cause location-based identifiers (a.k.a URL's) to become invalid. Content addressing makes no assumption about the current location (or locations) of the data. 
- Content addressing preserves the history of content. A CID represents a snapshot of a document at a given time. 

Laconic leverages IPFS and IPLD to provide a novel solutions for content addressing and indexing.
