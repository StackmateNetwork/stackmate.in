---
title: "Storage"
date: 2020-04-28T14:40:12+02:00
draft: false
weight: 2
pre: '<i class="fas fa-lock"></i> '
---


### Bitcoin Storage Models

Bitcoin storage can be broadly classified into three, ranked based on expected features:

<div class="descriptor-support-table">

| Features | Custodian | Self-Custody | Shared-Custody |
| -------- | --------------- | --------------- | ------------ |
|Definition| Coins held by your partner on your behalf.| Coins held by you alone.| Coins held by you AND a your partner(s), based on pre-defined conditions. | 
| Ease-of-use | 1 | 2 | 3* |
| Privacy | 3 | 1 | 2 |
| Security | 3 | 2 | 1 |

</div>

Most of us are familiar with the first two models. 

All exchange wallets provide custodian wallets. 

Green, Samourai, Wasabi etc., are examples of self-custody wallets; where you are the sole bearer of the keys.

Both custodian and self-custodian models present the problem of being `single points of failure`.

Either your exchange OR you, could get compromised.

# Shared-Custody

```text
Our mobile wallet ApnaBitcoin, at its core, seeks to to provide greater Ease-of-Use for shared-custody wallets.
```
With shared custody, coins are locked by MORE THAN ONE KEY - offering the highest levels of security Bitcoin has to offer. 

With shared-custody - `a single compromised key does not result in loss of funds` 

ApnaBitcoin allows you to appoint any other Bitcoin holder to take part in a scripted Bitcoin contract, and create additional layers of protection around your Bitcoin.

You can pair ApnaBitcoin with your existing hardware wallet to monitor your solo account, generate addresses to receive funds, monitor history and even build transactions* for you to sign as an individual key holder and broadcast. 

> ** `PartiallySignedBitcoinTransaction` or `psbt` is how we build transactions with only public key data; preparing it for the private key holder to sign. We work seamlessly with any wallet that supports `psbt`. 

Additionally, the same hardware public key can be used to create a new multi-sig wallet with another friend's hardware as the second signatory.

This new multi-sig wallet will generate its own set of addresses into which you can receive funds.

Moving these funds will require both one to sign and pass over to the next, a `psbt` to finalize and broadbast to the network.

```
ApnaBitcoin pairs best with ColdCard or Trezor.
```
This allows you to create multiple wallets from a single hardware signer, each with different spending conditions involving other bitcoiners.

Our servers only require your public keys to help you manage your account. You and your chosen signatories' are the sole custodians of the coin. 

Where you chose our server to be a signatory, it only maintains ITS OWN private key, and all other signatories' public keys.

# Multi-Signature

The most common form of a shared-custody contract is a `multi-signature`. 

Multi-signature is a spending condition where more than one key has to sign a transaction to move the coin locked in these addresses.

This means there is n/m possibilities of multi-sig. So we made it simple. 

```
We offer three types of multi-signature configurations:
```

##  Jetski
### 2/3 Multi-Sig w/server
> Est. July 15, 2021

In this setup, you maintain control of 2/3 keys, where one key is on your mobile device for easy signing, and the other key is in your cold hardware, just to use incase of emergency. 

For daily spending, your mobile key and our server as an automated signatory, can move funds. 

If you lose your mobile and/or its associated seed, you can still recover it with your hardware wallet and our signature.

A signatory partner for individuals.

## Cruiser
### [3-4]/5  (server optional)
> Est. July 15, 2021

The same setup as above, for a household; where we maintain a single key as a backup and optional automated signatory.

## Submarine (server optional)
### [5-9]/12 
> Est. July 15, 2021

The same setup as above, for joint families.

# Timelocks

Another form of shared-custody contract is a timelock.

Bitcoin allows us to create spending conditions that will alter over time.

Similar to multi-sigs; there a large number of arbitrary possibilites with timelocks, so we condensed it down to a few:

## Shoulders-of-Giants
> Est. September 15, 2021

In this setup, you are the only required signatory for a given period of time; after which another public key can also sign as the only required signatory.

Use cases of this include 

`appoint your own trusted custodian to act as a backup service to be able to unlock your coin after a timelock, in the event that you lose your keys.` 

`create a will or inheritence plan, where rather than sharing copies of your seed(subject to the angry rogue son problem), you create a more sovereign contract for your wealth to be securely handed down.`

