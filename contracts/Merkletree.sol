// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Merkletree {

    // Array to store hashes of transactions
    bytes32[] public hashes;

    // Array containing sample transactions
    string[4] transactions = [
        "TX1: Bob -> David",
        "TX1: David -> Bob",
        "TX1: Alica -> Mike",
        "TX1: Mike -> Alica"
    ];

    /**
     * @dev Constructor to initialize the Merkle tree by hashing transactions and building the tree structure.
     */
    constructor() {
        // Generate hashes for each transaction and store them in the hashes array
        for(uint i = 0; i < transactions.length; i++) {
            hashes.push(makeHash(transactions[i]));
        }

        // Build the Merkle tree from the transaction hashes
        uint count = transactions.length;
        uint offset = 0;
        while(count > 0) {
            for (uint i = 0; i < count - 1; i += 2) {
                // Calculate parent hash by hashing the concatenation of two child hashes
                hashes.push(keccak256(
                    abi.encodePacked(
                        hashes[offset + i],
                        hashes[offset + i + 1]
                    )
                ));
            }
            offset += count;
            count = count / 2;
        }
    }

    /**
     * @dev Function to encode a string into bytes.
     * @param input The string to be encoded.
     * @return The encoded bytes.
     */
    function encode(string memory input) public pure returns(bytes memory) {
        return abi.encodePacked(input);
    }

    /**
     * @dev Function to calculate the hash of a string.
     * @param input The string to be hashed.
     * @return The hash value.
     */
    function makeHash(string memory input) public pure returns(bytes32) {
        return keccak256(encode(input));
    }

    /**
     * @notice Checks if a transaction is included in the Merkle tree.
     * @dev Compares the calculated root hash with the provided root hash.
     * @param _transactions The transaction for which inclusion is being checked.
     * @param index The index of the transaction in the Merkle tree.
     * @param root The root hash of the Merkle tree.
     * @param proof The array of hashes required to prove inclusion of the transaction.
     * @return true if the transaction is included, false otherwise.
     */
    function check(string memory _transactions, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool) {
        bytes32 hash = makeHash(_transactions);
        for(uint i = 0; i < proof.length; i++) {
            bytes32 element = proof[i];
            if(index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, element));
            } else {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index = index / 2;
        }   
        return hash == root;
    }
}
