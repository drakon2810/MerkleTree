# Merkle Tree Contract

This repository contains a Solidity smart contract implementing a Merkle tree data structure. 

## Overview

The Merkle tree is a fundamental cryptographic data structure that enables efficient verification of the integrity and inclusion of data within a large dataset. This contract provides functionalities to construct a Merkle tree from a set of transactions and to verify the inclusion of a transaction in the tree using a Merkle proof.

## Usage

### Contract Deployment

To deploy the Merkle tree contract, follow these steps:

1. Deploy the contract to a supported Ethereum network (e.g., Ropsten, Rinkeby, or a local development network).

2. After deployment, the constructor of the contract automatically builds the Merkle tree using predefined sample transactions. These transactions are hardcoded in the contract for demonstration purposes.

### Verifying Transaction Inclusion

To verify the inclusion of a transaction in the Merkle tree, the `check` function is used. This function takes the following parameters:

- `_transactions`: The transaction for which inclusion is being checked.
- `index`: The index of the transaction in the Merkle tree.
- `root`: The root hash of the Merkle tree.
- `proof`: An array of hashes required to prove the inclusion of the transaction.

### Example

```solidity
// Deploy the contract
Merkletree merkleTree = new Merkletree();

// Verify transaction inclusion
bool isIncluded = merkleTree.check("TX1: Bob -> David", 0, <root_hash>, [<proof_hashes>]);
