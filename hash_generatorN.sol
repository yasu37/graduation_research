// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./system.sol";

/// @dev ハッシュ値を生成するコントラクト
contract HashGenerator is System {
    function generateN(uint labelid, address shipper, uint shipTimes) internal pure returns (bytes32) {
        /// @dev 荷物ラベルIDと荷物情報からハッシュ値を生成する関数
        return keccak256(abi.encodePacked(labelid, shipper, shipTimes));
    }

}
