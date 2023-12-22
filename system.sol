// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract System {
    struct TransactionInfo {
        /// @dev BCに登録する値を格納する構造体
        string[] encryptedVerification;               /// 暗号化した確認用情報を格納する配列
        bool validated;           /// @dev 荷物情報が確認済みかどうかの確認に使用する
        uint transactionNo;       /// @dev 荷物番号
        uint shipTimes;           /// @dev 経由回数
    }

    uint transactionCount = 1; /// @dev 取引の数を格納する変数 -> 荷物番号の割り振りに使用する

    mapping (uint => TransactionInfo) identInfoToTransactionInfo; /// @dev 識別情報(荷物番号)から確認用情報の構造体を検索するマッピング
    mapping (uint => uint) transactionNoToId;                            /// @dev 荷物番号から特徴量を検索するマッピング



} 