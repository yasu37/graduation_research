// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "./hash_generator0.sol";

// 受取人の処理
contract RecipientUnits is HashGenerator {
    function verification(uint labelId, address sender, address receiver, uint transactionNo) public returns (string memory, bytes32, bytes32) {

        // 確認用情報[0]と[0]'を格納する配列
        // 確認用情報[0]’を生成
        bytes32[2] memory Validation0 =  [identInfoToTransactionInfo[transactionNo].Verification[0], generate0(labelId, sender, receiver, transactionNo)];

        // 確認用情報[0]と[0]'を比較
        if(Validation0[0] == Validation0[1]) {
            // 成功した場合
            identInfoToTransactionInfo[transactionNo].validated = true;
            return ("Validation succeeded!!", Validation0[0], Validation0[1]);
        } else {
            // 失敗した場合
            return ("Validation failed!!", Validation0[0], Validation0[1]);
        }

    }

    // 復号化した確認用情報[n]と配送者から受信した確認用情報[n]を比較する。
    function identify(bytes32 sendValidation1, bytes32 sendValidation2, bytes32 decryptValidation1, bytes32 decryptValidation2, uint shipTimes) public pure returns (uint) {
        // 配送者から受信した確認用情報[n]を格納する配列
        bytes32[2] memory sendValidation =  [sendValidation1, sendValidation2];
        //　復号化した確認用情報[n]を格納する配列
        bytes32[2] memory decryptValidation =  [decryptValidation1, decryptValidation2];
        // 配送問題を引き起こした配送者番号
        uint problemDeliver=0;
        ///配送者１　→ 配送者２の順番で比較
        for(uint i=0; i< shipTimes; i++){
            if(sendValidation[i] == decryptValidation[i]) {
                problemDeliver++;
            } else {
                break;
            }
        }
        return (problemDeliver);
    }

}
