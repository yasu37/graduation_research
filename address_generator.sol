// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract Address {
   ///@dev 各エンティティのアドレスの決め方の1例(ランダム) ※オフチェーン予定
    function generateRandomAddress(uint256 randomNumber) public pure returns (address, address, address, address) {
        address senderAddress = address(uint160(uint256(keccak256(abi.encodePacked(randomNumber)))));
        address receiverAddress = address(uint160(uint256(keccak256(abi.encodePacked(randomNumber+1)))));
        address shipper1Address = address(uint160(uint256(keccak256(abi.encodePacked(randomNumber+2)))));
        address shipper2Address = address(uint160(uint256(keccak256(abi.encodePacked(randomNumber+3)))));
        return (senderAddress, receiverAddress, shipper1Address, shipper2Address);
    }
}
