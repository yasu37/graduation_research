// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./hash_generator.sol";

/// @dev 受取人の処理のコントラクト
contract IdentifierUnits is HashGenerator {
    ///受取人は暗号化された確認用情報をBCから取得する
    function getValidation(uint correctId) public view returns (string memory, string memory, string memory) {
        uint transactionNo = correctId;

        return (identInfoToTransactionInfo[transactionNo].encryptedVerification[0],
                identInfoToTransactionInfo[transactionNo].encryptedVerification[1],
                identInfoToTransactionInfo[transactionNo].encryptedVerification[2]
        );
    }

       ///真贋判定関数  復号化した確認用情報と配送者が生成した確認用情報を比較する。
    function identify(uint labelId, address sender, address receiver, uint transactionNo, bytes32 sendValidation1, bytes32 sendValidation2,bytes32 decryptValidation0, bytes32 decryptValidation1, bytes32 decryptValidation2, uint shipTimes) public returns (string memory, uint) {
        //受取人が配送者から送られてきた確認用情報の配列
        bytes32[2] memory sendValidation =  [sendValidation1, sendValidation2];
        //受取人が復号化した確認用情報の配列
        bytes32[3] memory decryptValidation =  [decryptValidation0, decryptValidation1, decryptValidation2];

       //問題が起こった配送者
        uint problemDeliver=0;

        if(decryptValidation[0] == generate0(labelId, sender, receiver, transactionNo)) {
            identInfoToTransactionInfo[transactionNo].validated = true;
            return ("Validation succeeded!!", 0);
        } else {
            ///配送者１　→ 配送者２の順番でチェック
            for(uint i=0; i<=shipTimes; i++){
                ///配送者が受取人に送った確認用情報
                if(sendValidation[i] == decryptValidation[i+1]) {
                    problemDeliver++;
                } else {
                    break;
                }
            }
            return ("Validation failed!!", problemDeliver);
        }

    }

}