/*
 * A system to rate a person by value on the basis of their skillset
 * Only owner can mint new coins
 * Each coin represents some value 
 * Owner circulates the coins mined by transfering them to others
 * Users can use upvotes and downvotes to increase or decrease a person's value
*/

pragma solidity ^0.4.0;

contract rate_me{
    
    //creator of the contract
    address private owner;
    
    //total generated till now
    uint private totalTokens;
    
    //generated today
    uint private tokensGen;
    
    //user info
    struct person_info{
        string name;
        uint person_value;
        uint tokensForTheDay;
    }
    
    //to map user_id with his/her address
    mapping(address => uint) private person_map;
    
    //to store user info where user_id is represented by index in array
    person_info[] private person;
    
    function rate_me(){
        //remembering creator
        owner = msg.sender;
    }
    
    //validating ownership 
    modifier ownership{
        require(owner == msg.sender);
        _;
    }
    
    // minted everyday at 8:00 AM IST by the contract creator
    function mint(uint amount) public ownership returns(uint){
        
        //generated today
        tokensGen = amount;
        
        //adding in total
        totalTokens += tokensGen;
        
        //distributing tokensGen to users as tokensForTheDay
        distri();
        
        //new coins created successfully 
        return totalTokens;
    }
    
    // distributing tokensForTheDay to the present users at 8:00 AM by te contract creator
    function distri() private ownership{
        for(uint i = 0; i < person.length; i++){
            person[i].tokensForTheDay = uint((person[i].person_value / totalTokens) * 100 * tokensGen);
        }
    }
    
    //adding user in the contract
    function add_user(address user_addr, string name) public returns (string){
        person_info user;
        user.name = name;
        user.person_value = 10;
        
        totalTokens += 10;
        
        person.push(user);
        
        person_map[user_addr] = person.length;
        
        //returing user_name
        return person[person.length - 1].name;
    }
    
    //method for users to upvote others using their tokensForTheDay
    function upvote(address upvoted) public returns(bool){
        uint id = person_map[msg.sender];
        
        if(person[id - 1].tokensForTheDay > 0){
            
            person[id - 1].tokensForTheDay -= 1;
            
            id = person_map[upvoted];
            person[id - 1].person_value += 1;    
        }
    }
    
}