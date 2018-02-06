pragma solidity ^0.4.0;

contract Voting{
    
    address private owner;
    mapping (address => bool) private caster;
    
    struct candidates{
        string name;
        uint votes;
    }
    
    candidates[4] private candid; 
    
    function Voting() public{
        
        owner = msg.sender;
        
        candid[0].name="Apoorv";
        candid[1].name="Banta";
        candid[2].name="Singh";
        candid[3].name="Kazo";
    }
    
    modifier already{
        assert(caster[msg.sender] == false);
        _;
    }
    
    function cast(uint _pos) already public returns (bool){
        if(caster[msg.sender] == false){
            
            candid[_pos - 1].votes += 1;
            
            caster[msg.sender] = true;
            return true;
        }
        
        return false;
    }
    
    function casted(uint _pos) public returns (uint){
        return candid[_pos -1].votes;
    }
}