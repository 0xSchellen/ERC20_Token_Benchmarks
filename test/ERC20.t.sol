// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "forge-std/Vm.sol";
//import "forge-std/console.sol";
import "forge-std/console2.sol";
import "../src/ERC20.sol";
import "../src/DEX.sol";

contract ERC20Test is DSTest {
    using stdStorage for StdStorage;

    Vm private vm = Vm(HEVM_ADDRESS);
    ERC20 private token;
    DEX private dex;
    StdStorage private stdstore;

    function setUp() public {
        // Deploy token contract
        token = new ERC20("UDEX", "UDEX");
        dex = new DEX();

        console.log("Sender", address(msg.sender));
        console.log("Token ", address(token));

        token._mint(address(5), 1000);
        token._mint(address(7), 1000);
        token._mint(address(9), 1000);
        vm.prank(address(5));
        token.approve(address(dex), 99);
    }

    // function testMint() public {
    //     token._mint(address(msg.sender), 100000000);
    //     uint256 saldo = token.balanceOf(address(msg.sender));
    //     // console.log();
    //     assertEq(saldo, 100000000);
    // }

    function testTransferFrom() public {
        vm.prank(address(dex));
        token.transferFrom(address(5), address(9), 20);    
        // assertEq(token.balanceOf(address(5)), 980);  
        // assertEq(token.balanceOf(address(7)), 1000);
        // assertEq(token.balanceOf(address(9)), 1020);      
    }

    function testTransferFromSol() public {
        vm.prank(address(dex));
        token.transferFromSol(address(5), address(9), 20);    
    //     // assertEq(token.balanceOf(address(5)), 980);  
    //     // assertEq(token.balanceOf(address(7)), 1000);
    //     // assertEq(token.balanceOf(address(9)), 1020);      
    }

    function testTransferFromSafe() public {
        // vm.prank(address(7));
        // token.balanceOf(address(5));
        // token.balanceOf(address(7));
        // token.balanceOf(address(9));

        //token.allowance(address(5),address(dex));

        dex._transferERC20(address(token), address(5), address(9), 20);    
        // assertEq(token.balanceOf(address(5)), 980);  
        // assertEq(token.balanceOf(address(7)), 1000);
        // assertEq(token.balanceOf(address(9)), 1020);      
    }

    // function testFailNoMintPricePaid() public {
    //     token.mintTo(address(1));
    // }

    // function testMintPricePaid() public {
    //     token.mintTo{value: 0.08 ether}(address(1));
    // }

    // function testFailMaxSupplyReached() public {
    //     uint256 slot = stdstore.target(address(token)).sig("currentTokenId()").find();
    //     bytes32 loc = bytes32(slot);
    //     bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
    //     vm.store(address(token), loc, mockedCurrentTokenId);
    //     token.mintTo{value: 0.08 ether}(address(1));
    // }

    // function testFailMintToZeroAddress() public {
    //     token.mintTo{value: 0.08 ether}(address(0));
    // }

    // function testNewMintOwnerRegistered() public {
    //     token.mintTo{value: 0.08 ether}(address(1));
    //     uint256 slotOfNewOwner = stdstore
    //         .target(address(token))
    //         .sig(token.ownerOf.selector)
    //         .with_key(1)
    //         .find();

    //     uint160 ownerOfTokenIdOne = uint160(uint256((vm.load(address(token),bytes32(abi.encode(slotOfNewOwner))))));
    //     assertEq(address(ownerOfTokenIdOne), address(1));
    // }

    // function testBalanceIncremented() public { 
    //     token.mintTo{value: 0.08 ether}(address(1));
    //     uint256 slotBalance = stdstore
    //         .target(address(token))
    //         .sig(token.balanceOf.selector)
    //         .with_key(address(1))
    //         .find();
        
    //     uint256 balanceFirstMint = uint256(vm.load(address(token), bytes32(slotBalance)));
    //     assertEq(balanceFirstMint, 1);

    //     token.mintTo{value: 0.08 ether}(address(1));
    //     uint256 balanceSecondMint = uint256(vm.load(address(token), bytes32(slotBalance)));
    //     assertEq(balanceSecondMint, 2);
    // }

    // function testSafeContractReceiver() public {
    //     Receiver receiver = new Receiver();
    //     token.mintTo{value: 0.08 ether}(address(receiver));
    //      uint256 slotBalance = stdstore
    //         .target(address(token))
    //         .sig(token.balanceOf.selector)
    //         .with_key(address(receiver))
    //         .find();

    //     uint256 balance = uint256(vm.load(address(token), bytes32(slotBalance)));
    //     assertEq(balance, 1);
    // }
    
    // function testFailUnSafeContractReceiver() public {
    //     vm.etch(address(1), bytes("mock code"));
    //     token.mintTo{value: 0.08 ether}(address(1));
    // }

    // function testWithdrawalWorksAsOwner() public {
    //     // Mint an token, sending eth to the contract
    //     Receiver receiver = new Receiver();
    //     address payable payee = payable(address(0x1337));
    //     uint256 priorPayeeBalance = payee.balance;
    //     token.mintTo{value: token.MINT_PRICE()}(address(receiver));
    //     // Check that the balance of the contract is correct
    //     assertEq(address(token).balance, token.MINT_PRICE());
    //     uint256 tokenBalance = address(token).balance;
    //     // Withdraw the balance and assert it was transferred
    //     token.withdrawPayments(payee);
    //     assertEq(payee.balance, priorPayeeBalance + tokenBalance);
    // }

    // function testWithdrawalFailsAsNotOwner() public {
    //     // Mint an token, sending eth to the contract
    //     Receiver receiver = new Receiver();
    //     token.mintTo{value: token.MINT_PRICE()}(address(receiver));
    //     // Check that the balance of the contract is correct
    //     assertEq(address(token).balance, token.MINT_PRICE());
    //     // Confirm that a non-owner cannot withdraw
    //     vm.expectRevert("Ownable: caller is not the owner");
    //     vm.startPrank(address(0xd3ad));
    //     token.withdrawPayments(payable(address(0xd3ad)));
    //     vm.stopPrank();
    // }
}

// contract Receiver is ERC721TokenReceiver {
//     function onERC721Received(
//         address operator,
//         address from,
//         uint256 id,
//         bytes calldata data
//     ) override external returns (bytes4){
//         return this.onERC721Received.selector;
//     }
// }

