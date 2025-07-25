// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

/**
 * ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░
 * ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░
 * ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░
 * ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░
 * ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░
 * ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░
 * ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░
 */

// @title: Donut NFT
// @notice: This is the ERC721 contract for the on-chain Donut NFT. A project for the Donut Testnet
// @dev: Base64 encoding is utilized to achieve 100% on-chain hosting
// @author: Chukwubuike Victory Chime @yeahChibyke (Github and Twitter)

// --- IMPORTS -- //
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract Donut is ERC721, Ownable {
    // -- ERRORS -- //
    error D__NonExistentDonut();

    // // -- ENUMS -- //
    // enum Network {
    //     eth,
    //     base,
    //     op
    // }

    // -- STORAGE- //
    uint256 private s_donutCounter;
    string private s_donutSvgUri;

    // -- CONSTRUCTOR -- //
    constructor(string memory _donutSvgUri) ERC721("Donut", "D") Ownable(msg.sender) {
        s_donutSvgUri = _donutSvgUri;
    }

    // -- EXTERNAL FUNCTIONS -- //

    function getDonut(address receiver) external {
        _safeMint(receiver, s_donutCounter);
        s_donutCounter++;
    }

    // -- PUBLIC FUNCTIONS -- //

    function tokenURI(uint256 donutId) public view virtual override returns (string memory) {
        if (ownerOf(donutId) == address(0)) {
            revert D__NonExistentDonut();
        }

        string memory imageURI = s_donutSvgUri;
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name(),
                        '", "description":"Steaming delicious donuts, for everyone", ',
                        '"attributes": [{"trait_type": "steaming and delicious", "value": uiniqu}], "image":"',
                        imageURI,
                        '"}'
                    )
                )
            )
        );
    }

    // -- INTERNAL FUNCTIONS -- //
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    // -- GETTER FUNCTIONS -- //
    function getDonutCounter() external view returns (uint256) {
        return s_donutCounter;
    }
}
