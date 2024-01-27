// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract System {
    struct TransactionInfo {
        // BCに登録する値を格納する構造体
        bytes32[] Verification;             // 確認用情報[0]を格納する配列
        string[] encryptedVerification;     // 暗号化した確認用情報[n]を格納する配列
        bool validated;                     // 荷物情報が確認済みかどうかの確認に使用する
        uint transactionNo;                 // 荷物番号
        uint shipTimes;                     // 経由回数
    }

    mapping (uint => TransactionInfo) identInfoToTransactionInfo; // 荷物番号から確認用情報の構造体を検索するマッピング

}
