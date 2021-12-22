// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC721/ERC721.sol)
pragma solidity ^0.8.0;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol';

contract MonNft is ERC721URIStorage {
     using Counters for Counters.Counter;
     Counters.Counter private idArticles;
    struct Article {
            uint256 id;
            address createur;
            string uri;
            uint prix;

    }

    mapping(uint256=>Article) public articles;
    mapping(uint256=>bool)public vendu;

     constructor() ERC721("MUKOLOS TOKEN","MKLS"){
     
     }


     function mint(string memory _uri,uint _prix) public returns(uint256) {
         
       idArticles.increment();
       uint index = idArticles.current();

       _mint(address(this),index);
       _setTokenURI(index,_uri);
       articles[index]=Article(index,msg.sender,_uri,_prix);
       return index;

     }

     function acheter(uint256 _id)payable external {
       require(_exists(_id));
       require(!vendu[_id]);
       require(msg.value==articles[_id].prix);
       _transfer(address(this),msg.sender,_id);
       payable(articles[_id].createur).transfer(msg.value);
       vendu[_id]=true;
     }

 

}