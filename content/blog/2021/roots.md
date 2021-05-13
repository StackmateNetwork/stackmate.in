---
title: "Roots"
description: "A brief introduction to the team"
authors: 
    - Vishal Menon
date: "2021-01-20"
tags: ["rust", "release"]
hidden: true
draft: false
---

#### Origins

```text
A bitcoin hodler, a bitcoin miner and a bitcoin developer met.
```

#### Vision

```text 
A sound monetary base.
```

#### Process

```text
Work with the larger bitcoin-core community to build relavant prodcuts that improve UX while preserving bitcoin-core fundamentals.
```


[paper wallet wiki article]: https://en.bitcoin.it/wiki/Paper_wallet
[previous version]: https://github.com/RCasatta/rusty-paper-wallet/tree/339fa4418d94f6fdd96f3d0301cab8a0bc09e8bd
[Rusty Paper Wallet]: https://github.com/RCasatta/rusty-paper-wallet
[support mnemonic]: https://github.com/RCasatta/rusty-paper-wallet/issues/5
[descriptors]: /descriptors
[bdk]: https://github.com/bitcoindevkit/bdk
[rust]: https://www.rust-lang.org/tools/install
[output]: /images/descriptor-based-paper-wallets/data-url.txt
[data URI scheme]: https://en.wikipedia.org/wiki/Data_URI_scheme
[bdk-cli]: https://github.com/bitcoindevkit/bdk-cli
[bitcoin testnet faucet]: https://bitcoinfaucet.uo1.net/
[confirm the funds were received]: https://mempool.space/testnet/address/tb1qu6lcua9w2zkarjj5xwxh3l3qtcxh84hsra3jrvpszh69j2e54x7q3thycw
[sweep tx]: https://mempool.space/testnet/tx/9ecd8e6be92b7edd8bf1799f8f7090e58f813825f826bdb771b4cdb444cdeb59
[spending policy demo]: /blog/2021/02/spending-policy-demo/#step-4-create-wallet-descriptors-for-each-participant
[guarantees]: https://github.com/bitcoin/bitcoin/blob/master/doc/descriptors.md#checksums

[^WIF]: Wallet Input Format, a string encoding a ECDSA private key  https://en.bitcoin.it/wiki/Wallet_import_format
[^WIF core]: Unless the user import the WIF directly into bitcoin core
[^sweep]: Some wallets refers to sweep as the action to create a transaction taking all the funds from the paper wallet and sending those to the wallet itself.
[^black zone]: Ideally, the black zone should be twice as long as the secret part to cover it back and front, long descriptor may leave a shorter black zone, ensure to have you printer set with vertical layout for best results.
