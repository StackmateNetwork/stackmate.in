---
title: "Solo Account Recovery"
description: "Demonstrates how to recover your solo account."
authors: 
    - Vishal Menon
date: "2021-02-23"
tags: ["guide", "recovery"]
hidden: true
draft: false
---

> This tutorial is a stripped down version of Steve Myers and Thundabirds article from bdk-cli

In this post we will use the [bdk-cli](https://github.com/bitcoindevkit/bdk-cli) tool to recover accounts from a bitcoin seed.

1. recover your seed's extended master key and derive child account keys
2. create a [PSBT](https://bitcoinops.org/en/topics/psbt/) to unlock your unspent bitcoin
3. sign and finalize the resulting PSBTs
4. broadcast and confirm spending transactions via [Blockstream](https://blockstream.info)

*Note: We use testnet in the examples for you to try. If you repeat these instructions on your own your mainnet seed - the extended keys, addresses, and other values will be different than shown in this post, but the end results should be the same.*

## Initial Setup

### Step 0: Install a recent version `bdk-cli`

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bdk-cli --features repl,electrum,esplora

# confirm bdk-cli is installed
bdk-cli --version
BDK CLI 0.2.0

# bdk-cli usage can be explored with the `help` sub-command
bdk-cli help
```

### Step 1: Recover extended master private key from a seed

Generate new extended private keys for each of our wallet participants:

```bash
bdk-cli key restore --mnemonic "witness poverty pulse crush era item game rose bargain quantum spawn sure way behave also basket journey worry stem entry toddler floor way bone" |  tee apna-key.json
{
  "fingerprint": "5adb4683",
  "xprv": "tprv8ZgxMBicQKsPeAuGznXJZwfWHgWo86dFuufRBZN7ZT44UzoNG2cYmZLNLrnsm7eXhGSeccRU2nTtxunT11UkpqrRhJQefBnFJeHBddF68bg"
}

```

### Step 2: Extract extended master private key

Here we use the `jq` Unix command to parse the json output of the `bdk-cli` commands.

```bash
sudo apt-get install jq -y

export MY_XPRV=$(cat apna-key.json | jq -r '.xprv')

```

### Step 3: Derive extended public keys

All stackmate live wallets use account 0 by the standard [BIP-84](https://github.com/bitcoin/bips/blob/master/bip-0084.mediawiki) key path: `m/84h/1h/0h/0/*` to derive extended public keys to share with other wallet participants.

Note that the `key derive` sub-command will generate a tpub for the last hardened node in the given derivation path. You'll also notice that `bdk-cli` will returns our tpub with the key origin (fingerprint/path) added to it (the metadata part that looks like `[5adb4683/84'/1'/0']` right before the tpub). This key origin information is not necessary in order to use a tpub and generate addresses, but it's good practice to include it because some signers require it.

```bash
export MY_XPUB=$(bdk-cli key derive --xprv $MY_XPRV --path "m/84'/1'/0'/0" | jq -r ".xpub")
echo \"$MY_XPUB\"
"[5adb4683/84'/1'/0']tpubDCyRBuncqwyAjSNiw1GWLmwQsWyhgPMEBpx3ZNpnCwZwf3HXerspTpaneN81KRxkwj8vjqH9pNWEPgNhen7dfE212SHfxBBbsCywxQGxvvu/0/*"

```

### Step 4: Create wallet descriptor


```bash
export MY_DESCRIPTOR="wpkh(pk($MY_XPRV/84'/1'/0'/0/*))"

```

### Step 5: Sync descriptor wallet and confirm balance

This step must be done by apna, Bob, and Carol so their individual descriptor wallets know about the faucet transaction they will later be spending the output of.

```bash
bdk-cli wallet -w apna -d $MY_DESCRIPTOR sync       
{}
bdk-cli wallet -w apna -d $MY_DESCRIPTOR get_balance
{
  "satoshi": 10000
}
```

### Step 6: View wallet spending policies

This can also be done by any wallet participant, as long as they have the same descriptor and extended public keys from the other particpants..

```bash
bdk-cli wallet -w apna -d $MY_DESCRIPTOR policies
{
  "external": {
    "contribution": {
      "conditions": {
        "0": [
          {}
        ],
        "3": [
          {
            "csv": 2
          }
        ]
      },
      "items": [
        0,
        3
      ],
      "m": 3,
      "n": 4,
      "type": "PARTIAL"
    },
    "id": "ydtnup84",
    "items": [
      {
        "contribution": {
          "condition": {},
          "type": "COMPLETE"
        },
        "fingerprint": "5adb4683",
        "id": "uyxvyzqt",
        "satisfaction": {
          "type": "NONE"
        },
        "type": "SIGNATURE"
      },
      {
        "contribution": {
          "type": "NONE"
        },
        "fingerprint": "5fdec309",
        "id": "dzkmxcgu",
        "satisfaction": {
          "type": "NONE"
        },
        "type": "SIGNATURE"
      },
      {
        "contribution": {
          "type": "NONE"
        },
        "fingerprint": "de41e56d",
        "id": "ekfu5uaw",
        "satisfaction": {
          "type": "NONE"
        },
        "type": "SIGNATURE"
      },
      {
        "contribution": {
          "condition": {
            "csv": 2
          },
          "type": "COMPLETE"
        },
        "id": "8kel7sdw",
        "satisfaction": {
          "type": "NONE"
        },
        "type": "RELATIVETIMELOCK",
        "value": 2
      }
    ],
    "satisfaction": {
      "type": "NONE"
    },
    "threshold": 3,
    "type": "THRESH"
  },
  "internal": null
}
```

### Step 7: Create spending transaction

The transaction can also be created by apna, Bob, or Carol, or even an untrusted coordinator that only has all three tpubs. 

Note that the argument provided to the --external_policy flag contains the id retrieved from the `policies` subcommand in the above step, in this case `ydtnup84`.

```bash
bdk-cli wallet -w apna -d $MY_DESCRIPTOR create_tx -a --to tb1qm5tfegjevj27yvvna9elym9lnzcf0zraxgl8z2:0 --external_policy "{\"ydtnup84\": [0,1,2]}"
{
  "details": {
    "fees": 169,
    "height": null,
    "received": 0,
    "sent": 10000,
    "timestamp": 1614058791,
    "transaction": null,
    "txid": "3b9a7ac610afc91f1d1a0dd844e609376278fe7210c69b7ef663c5a8e8308f3e"
  },
  "psbt": "cHNidP8BAFIBAAAAAYx7T0cL7EoUYBEU0mSL6+DS4VQafUzJgAf0Ftlbkya5AQAAAAD/////AWcmAAAAAAAAFgAU3RacollkleIxk+lz8my/mLCXiH0AAAAAAAEBKxAnAAAAAAAAIgAgCBH16JNfSPhmjJR75EdDB+gSCEF7tStNOLqw/k3BvA0BBXchA3c1Ak2kcGOzOh6eRXFKfpnpzP1lzfcXIYhxFGZG51mxrHwhA75YDXRLDLt+eX5UsE03mIGUSsQP2MrJ9lm17cGXDw2mrJN8IQIvNjaP+mwNC0DtgaB6ENB/DPPlbUDR6+NZ4Sw070jzOKyTfHZjUrJpaJNThyIGAi82No/6bA0LQO2BoHoQ0H8M8+VtQNHr41nhLDTvSPM4DO66tnIAAAAAAAAAACIGA3c1Ak2kcGOzOh6eRXFKfpnpzP1lzfcXIYhxFGZG51mxGFrbRoNUAACAAQAAgAAAAIAAAAAAAAAAACIGA75YDXRLDLt+eX5UsE03mIGUSsQP2MrJ9lm17cGXDw2mDEMxpeYAAAAAAAAAAAAA"
}

export UNSIGNED_PSBT=$(bdk-cli wallet -w apna -d $MY_DESCRIPTOR create_tx -a --to tb1qm5tfegjevj27yvvna9elym9lnzcf0zraxgl8z2:0 --external_policy "{\"ydtnup84\": [0,1,2]}" | jq -r ".psbt")
```

### Step 8: Sign and finalize PSBTs

```bash
# SIGN AND FINALIZE PSBT
bdk-cli wallet -w apna -d $MY_DESCRIPTOR sign --psbt $UNSIGNED_PSBT
{
  "is_finalized": true,
  "psbt": "cHNidP8BAFIBAAAAAYx7T0cL7EoUYBEU0mSL6+DS4VQafUzJgAf0Ftlbkya5AQAAAAD/////AWcmAAAAAAAAFgAU3RacollkleIxk+lz8my/mLCXiH0AAAAAAAEBKxAnAAAAAAAAIgAgCBH16JNfSPhmjJR75EdDB+gSCEF7tStNOLqw/k3BvA0iAgIvNjaP+mwNC0DtgaB6ENB/DPPlbUDR6+NZ4Sw070jzOEcwRAIgRPXSwFLfzD1YQzw5FGYA0TgiQ+D88hSOVDbvyUZDiPUCIAbguaSGgCbBAXo5sIxpZ4c1dcGkYyrrqnDjc1jcdJ1CASICA3c1Ak2kcGOzOh6eRXFKfpnpzP1lzfcXIYhxFGZG51mxSDBFAiEA0kdkvlA+k5kUBWVUM8SkR4Ua9pnXF66ECVwIM1l0doACIF0aMiORVC35+M3GHF2Vl8Q7t455mebrr1HuLaAyxBOYASICA75YDXRLDLt+eX5UsE03mIGUSsQP2MrJ9lm17cGXDw2mRzBEAiBPJlQEnuVDHgfgOdTZNlIcRZz2iqHoMWfDmLMFqJSOQAIgCuOcTKp/VaaqwIjnYfMKO3eQ1k9pOygSWt6teT1o13QBAQV3IQN3NQJNpHBjszoenkVxSn6Z6cz9Zc33FyGIcRRmRudZsax8IQO+WA10Swy7fnl+VLBNN5iBlErED9jKyfZZte3Blw8NpqyTfCECLzY2j/psDQtA7YGgehDQfwzz5W1A0evjWeEsNO9I8zisk3x2Y1KyaWiTU4ciBgIvNjaP+mwNC0DtgaB6ENB/DPPlbUDR6+NZ4Sw070jzOBjeQeVtVAAAgAEAAIAAAACAAAAAAAAAAAAiBgN3NQJNpHBjszoenkVxSn6Z6cz9Zc33FyGIcRRmRudZsQwpbm6KAAAAAAAAAAAiBgO+WA10Swy7fnl+VLBNN5iBlErED9jKyfZZte3Blw8NpgxDMaXmAAAAAAAAAAABBwABCP1TAQUARzBEAiBE9dLAUt/MPVhDPDkUZgDROCJD4PzyFI5UNu/JRkOI9QIgBuC5pIaAJsEBejmwjGlnhzV1waRjKuuqcONzWNx0nUIBRzBEAiBPJlQEnuVDHgfgOdTZNlIcRZz2iqHoMWfDmLMFqJSOQAIgCuOcTKp/VaaqwIjnYfMKO3eQ1k9pOygSWt6teT1o13QBSDBFAiEA0kdkvlA+k5kUBWVUM8SkR4Ua9pnXF66ECVwIM1l0doACIF0aMiORVC35+M3GHF2Vl8Q7t455mebrr1HuLaAyxBOYAXchA3c1Ak2kcGOzOh6eRXFKfpnpzP1lzfcXIYhxFGZG51mxrHwhA75YDXRLDLt+eX5UsE03mIGUSsQP2MrJ9lm17cGXDw2mrJN8IQIvNjaP+mwNC0DtgaB6ENB/DPPlbUDR6+NZ4Sw070jzOKyTfHZjUrJpaJNThwAA"
```

### Step 9: Broadcast finalized PSBT

```bash
bdk-cli wallet -w apna -d $MY_DESCRIPTOR broadcast --psbt $FINAL_PSBT
{
  "txid": "3b9a7ac610afc91f1d1a0dd844e609376278fe7210c69b7ef663c5a8e8308f3e"
}
```

### Step 10: Confirm transaction included in a testnet block

[https://mempool.space/testnet/tx/3b9a7ac610afc91f1d1a0dd844e609376278fe7210c69b7ef663c5a8e8308f3e](https://mempool.space/testnet/tx/3b9a7ac610afc91f1d1a0dd844e609376278fe7210c69b7ef663c5a8e8308f3e)

And new wallet balance is now zero.

```bash
bdk-cli wallet -w apna -d $MY_DESCRIPTOR sync
{}
bdk-cli wallet -w apna -d $MY_DESCRIPTOR get_balance
{
  "satoshi": 0
}
```

### DONE!
