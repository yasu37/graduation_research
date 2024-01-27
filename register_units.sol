// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./hash_generator0.sol";

/// 発送者の処理
contract RegisterUnits is HashGenerator {

    // 発送者はラベルID、発送者/受取人アドレス、暗号化した確認用情報[n]を送信。  ※配送者が2人いる場合、n=1, 2
    function registration(uint correctId, address sender, address receiver, string memory encryptedVerification1, string memory encryptedVerification2) external returns (uint){
        // 荷物番号の生成 ※決め方の１例として、 固有ラベルIDと同じ値。
        uint transactionNo = correctId;
        // 確認用情報[0]を生成
        bytes32 Verification0 = generate0(correctId, sender, receiver, transactionNo);
        // 検証結果を登録
        identInfoToTransactionInfo[transactionNo].validated = false;
        // 確認用情報[0]を登録
        identInfoToTransactionInfo[transactionNo].Verification.push(Verification0);
        // 暗号化した確認用情報[1]を登録
        identInfoToTransactionInfo[transactionNo].encryptedVerification.push(encryptedVerification1);
        // 暗号化した確認用情報[2]を登録
        identInfoToTransactionInfo[transactionNo].encryptedVerification.push(encryptedVerification2);
        // 荷物番号を発送者と受取人に送信
        return transactionNo;
    }

    function verificationGenerateN(uint labelid, address shipper, uint shipTimes) public pure returns (bytes32) {
        // 発送者が確認用情報[n]を生成
        return keccak256(abi.encodePacked(labelid, shipper, shipTimes));
    }

}
