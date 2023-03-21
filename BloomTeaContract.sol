// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract HelloWorld {
    struct Tea{
        address owner;
        string typee;
        string name;
        uint256 price;
        string size;
        string image;
        string bg_image;
        string shop_image;
        string discribe;
        string counter;
        address[] buyers;
        uint256[] buys;
    }

    struct Extra{
        address owner;
        string typee;
        string name;
        uint256 price;
        string size;
        string image;
        string shop_image;
        string discribe;
        string counter;
        address[] buyers;
        uint256[] buys;
    }

    mapping(uint256 => Tea) public Teas;
    mapping(uint256 => Extra) public Extras;

    uint256 public numberOfTeas = 0;
    uint256 public numberOfExtras = 0;

    function createTea(address _owner, string memory _typee, string memory _name, uint256  _price, string memory _size, string memory _image, string memory _bg_image, string memory _shop_image, string memory _discribe, string memory _counter) public returns(uint256) {
        Tea storage tea = Teas[numberOfTeas];

        tea.owner = _owner;
        tea.typee = _typee;
        tea.name = _name;
        tea.price = _price;
        tea.size = _size;
        tea.image = _image;
        tea.bg_image = _bg_image;
        tea.shop_image = _shop_image;
        tea.discribe = _discribe;
        tea.counter = _counter;

        numberOfTeas++;

        return numberOfTeas - 1;

    }

    function createExtra(address _owner, string memory _typee, string memory _name, uint256  _price, string memory _size, string memory _image, string memory _shop_image, string memory _discribe, string memory _counter) public returns(uint256) {
        Extra storage extra = Extras[numberOfTeas];

        extra.owner = _owner;
        extra.typee = _typee;
        extra.name = _name;
        extra.price = _price;
        extra.size = _size;
        extra.image = _image;
        extra.shop_image = _shop_image;
        extra.discribe = _discribe;
        extra.counter = _counter;

        numberOfExtras++;

        return numberOfExtras - 1;

    }

    function buyTea(uint256 _id) public payable{
        uint256 amount = msg.value;
        Tea storage tea = Teas[_id];

        require(amount == tea.price, "Amount is not equal tea's price");

        tea.buyers.push(msg.sender);
        tea.buys.push(amount);

        (bool sent,) = payable(tea.owner).call{ value: amount}("");

        if (sent) {
            // do something if transaction was succesfull

        }
    }

    function buyExtra(uint256 _id) public payable {
        uint256 amount = msg.value;

        Extra storage extra = Extras[_id];

        extra.buyers.push(msg.sender);
        extra.buys.push(amount);

        (bool sent,) = payable(extra.owner).call{ value: amount}("");

        if (sent) {
            // do something if transaction was succesfull

        }
    }

    function getTeaBuyers(uint256 _id) view public returns(address[] memory,uint256[] memory) {
        return(Teas[_id].buyers, Teas[_id].buys);
    }

    function getExtraBuyers(uint256 _id) view public returns(address[] memory,uint256[] memory) {
        return (Extras[_id].buyers, Extras[_id].buys);

    }
    
    function getTeas() public view returns(Tea[] memory) {
        Tea[] memory allTeas = new Tea[](numberOfTeas);

        for(uint i = 0; i < numberOfTeas; i++){
            Tea storage item = Teas[i];

            allTeas[i] = item;
        }

        return allTeas;
    }
    function getExtras() public view returns(Extra[] memory) {
        Extra[] memory allExtras = new Extra[](numberOfExtras);

        for(uint i = 0; i < numberOfExtras; i++){
            Extra storage item = Extras[i];

            allExtras[i] = item;
        }

        return allExtras;
    }
}
