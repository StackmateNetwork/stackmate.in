---
title: "Storage"
date: 2020-04-28T14:40:12+02:00
draft: false
weight: 2
pre: '<i class="fas fa-lock"></i> '
---


### Not your keys, not your coin.

> You either protect your money via crypto keys and proof-of-work, or, you protect it with physical vaults and lethal weapons. There is no third option. - Lombrozo (2021)

Bitcoin storage can be broadly classified into three, ranked based on expected features:

<div class="descriptor-support-table">

> Rank #1 is best

| Features | Custodian | Self-Custody | Shared-Custody |
| -------- | --------------- | --------------- | ------------ |
|Definition| Coins held by a bank on your behalf.| Coins held by you alone.| Coins held by you AND your partner(s), based on pre-defined conditions. | 
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
Our mobile wallet, at its core, seeks to to provide greater Ease-of-Use for shared-custody wallets.
```
With shared custody, coins are locked by MORE THAN ONE KEY.

This means - `a single compromised key does not result in loss of funds` 

We allow you to appoint ANY other Bitcoin holder to take part in a scripted Bitcoin contract, and create additional layers of protection around your Bitcoin.

You can pair the mobile wallet with your existing hardware to monitor a solo account, generate addresses to receive funds, monitor history and even build transactions* for you to sign as an individual key holder and broadcast. 

> ** `PartiallySignedBitcoinTransaction` or `psbt` is representation of a bitcoin transaction, which can be created with only public key data. This `psbt` can then passed to the approriate private key holder to sign and broadcast. We work seamlessly with any wallet that supports `psbt`. 


Additionally, the same hardware public key can be used to create a new multi-sig contract with another friend's hardware as the second signatory.

This new multi-sig contract will generate its own set of addresses into which you can receive funds.

This allows you to create multiple contracts from a single hardware signer, each with different spending conditions involving other bitcoiners.


```
The mobile wallet pairs best with ColdCard or Trezor.
```
Moving these funds will require an initiating party to sign a `psbt` and pass over to the next signatory to finalize and broadbast to the network.


# Multi-Signature

The most common form of a shared-custody contract is a `multi-signature`. 

Multi-signature is a spending condition where more than one key has to sign a transaction to move the coin locked in these addresses.

This means there are n/m possibilities of multi-sig. So we made it simple. 

```
We offer three types of multi-signature configurations as paid services:
```

##  Jetski
### 2/3 Multi-Sig w/server
#### Built for individuals
> Est. August 18, 2021

In this setup, you maintain control of 2/3 keys, where one key is on your mobile device for easy signing, and the other key is in your cold hardware, just to use incase of emergency. 

For daily spending, your mobile key and our server as an automated signatory, can move funds.

If you lose your mobile and/or its associated seed, you can still recover it with your hardware wallet and our signature.

> Multi-sig that feels like a single sig. With taproot support in progress, this will soon even look like single sig.

`Cost: 190,000 sats/year`

*Cheaper than a Netflix subscription*

## Yacht
### [3-4]/5 Multi-Sig (server optional)
#### Built for households and small businesses

> Est. September 18, 2021

The same setup as above with:
- 5 key threshold
- extended support over Jitsi
- 1 hardware wallet of choice between [Trezor](https://trezor.io) (Beginner) OR [ColdCard](https://coldcardwallet.com) (Advanced)

`Cost: 3 million sats/year`

## Submarine
### [5-9]/12 Multi-Sig
#### Built for enterprise.

> Est. September 18, 2021

The same setup as above with:
- 9 key threshold
- custom scripts and specialized bitcoin infrastructure
- premium support over Signal w/a dedicated account manager.
- 3 hardware wallets of choice between [Trezor](https://trezor.io) (Beginner) OR [ColdCard](https://coldcardwallet.com) (Advanced)


`Cost: 9 million sats/year`

# Timelocks

Another form of shared-custody contract is a timelock.

Bitcoin allows us to create spending conditions that will alter over time.

Similar to multi-sigs; there a large number of arbitrary possibilites with timelocks, so we condensed it down to a few:

## Raft
#### Built for everyone

> Est. December 09, 2021. 

> The reason this is last on our roadmap is because it requires an update from bitcoin-core. Hang in there ;)

In this setup, you set a time in the future as a failsafe timelock. Appoint another Bitcoiner to be your raft partner by requesting their public key. Allow only yourself to move the funds at any point in time and allow your partner to move the coin ONLY AFTER the timelock. 

Use cases of this include 

`appoint your own trusted custodian to act as a backup service to be able to unlock your coin after a timelock, in the event that you lose your keys.` 

`create a will or inheritence plan, where rather than sharing copies of your seed(subject to the angry rogue son problem), you create a more sovereign contract for your wealth to be securely handed down.`

```
Cost: : FREE
```

### Subscription Terms

Your subscription is primarily for support and the monitoring features on our mobile wallet. Your funds are not LOCKED; if you are overdue on fees or otherwise. You will just be restricted from paid support channels and mobile monitoring. Ultimately, you are in control of your coin, and you only pay us for support and convenience.