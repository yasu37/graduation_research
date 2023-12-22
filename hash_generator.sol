// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./system.sol";

/// @dev ハッシュ値を生成するコントラクト
contract HashGenerator is System {
    ///確認用情報[0]用 →　ラベルID、発送者アドレス、受取人アドレス、荷物番号
    function generate0(uint id, address sender, address receiver, uint transactionNo) internal pure returns (bytes32) {
        /// @dev 荷物ラベルIDと荷物情報からハッシュ値を生成する関数
        return keccak256(abi.encodePacked(id, sender, receiver, transactionNo));
    }
    ///確認用情報[n]用 → ラベルID、配送者アドレス、確認用情報[n-1]、経由回数
    function generateN(uint id, address shipper, bytes32 verificationInfo, uint shipTimes) internal pure returns (bytes32) {
        /// @dev 荷物ラベルIDと荷物情報からハッシュ値を生成する関数
        return keccak256(abi.encodePacked(id, shipper, verificationInfo, shipTimes));
    }
}