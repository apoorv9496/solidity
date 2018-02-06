pragma solidity ^0.4.0;

contract coin{
    
    //creator of the contract
    address private owner;
    
    mapping(address => uint) private balances;
    
    function coin(){
        owner = msg.sender;
    }
    
    //validating ownership 
    modifier ownership{
        require(owner == msg.sender);
        _;
    }
    
    function mint(uint amount) public ownership returns (string){
        
        balances[msg.sender] += amount; 
        
        //new coins created successfully 
        return "minted";
    }
    
    function balance(address balance_of) public returns (uint){
            return balances[balance_of];
    }
    
    function transfer(address to, uint amount) public returns(bool){
        if(balances[msg.sender] >= amount){
            balances[msg.sender] -= amount;
            balances[to] += amount;
        }
    }
}