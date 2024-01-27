// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./hash_generatorN.sol";

// 配送者の処理のコントラクト ※オフチェーン
contract ShipperUnits is HashGenerator {
    function shipperProcess(uint labelid, address shipper, uint shipTimes) public pure returns (bytes32) {
        // 配送者が確認用情報[n]を生成
        return keccak256(abi.encodePacked(labelid, shipper, shipTimes));
    }
}
