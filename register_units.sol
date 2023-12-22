// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./hash_generator.sol";

/// @dev 発送者の処理のコントラクト
contract RegisterUnits is HashGenerator {

    ///@dev 全ての確認用情報を生成(例；配送者が2人の場合)
    function verification(uint correctId, address sender, address receiver, address shipper1, address shipper2, uint shipTimes) external returns (bytes32){
        /// 荷物番号の決め方の１例(例；固有ラベルIDと同じにする)
        uint transactionNo = correctId;
        identInfoToTransactionInfo[transactionCount].validated = false;

        /// @dev 確認用情報[0]、[1]、[2]を生成 & 受取人に送信
        return generateN(correctId, shipper2, generateN(correctId, shipper1, generate0(correctId, sender, receiver, transactionNo), shipTimes-1), shipTimes);
    }

    ///暗号化した確認用情報をBCに登録する関数
    function registration(uint correctID, string memory encryptedVerification1, string memory encryptedVerification2, string memory encryptedVerification3) public returns (string memory, string memory, string memory){
        uint transactionNo = correctID;

        identInfoToTransactionInfo[transactionNo].encryptedVerification.push(encryptedVerification1);
        identInfoToTransactionInfo[transactionNo].encryptedVerification.push(encryptedVerification2);
        identInfoToTransactionInfo[transactionNo].encryptedVerification.push(encryptedVerification3);

        return (identInfoToTransactionInfo[transactionNo].encryptedVerification[0],
                identInfoToTransactionInfo[transactionNo].encryptedVerification[1],
                identInfoToTransactionInfo[transactionNo].encryptedVerification[2]
        );
    }

}