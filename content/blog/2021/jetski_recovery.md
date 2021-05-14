---
title: "Jetski Account Recovery"
description: "Demonstrates how to recover a 2/3 multi-sig account"
authors: 
    - Vishal Menon
date: "2021-02-23"
tags: ["guide", "recovery"]
hidden: true
draft: false
---

In this post we will use the [bdk-cli](https://github.com/bitcoindevkit/bdk-cli) tool to recover a Jetski 2/3 multi-sig account. This would be useful in the unlikely event of downtime at Stackmate.

1. recover your seed's extended master key and derive child account keys
2. create a [PSBT](https://bitcoinops.org/en/topics/psbt/) to unlock your unspent bitcoin
3. sign and finalize the resulting PSBTs
4. broadcast and confirm spending transactions via [Blockstream](https://blockstream.info)

