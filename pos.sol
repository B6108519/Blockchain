pragma solidity ^0.5.1;

contract ProofOfStudent {
    
    struct Ordersdata{
        string name;
        uint timestamp;
        address addr;
    }
    
  //mapping (bytes32 => bool) private listOrder;
  mapping (uint => Ordersdata) private listOrder;
  mapping (uint => string) private listCustommer;
  mapping (uint => uint) private listTimestamp;
  mapping (uint => address) private listAddress;

  //---events---
  event OrderAdded(
    address from,   
    string text,
    uint datetime,
    bytes32 hash
  );
  
  event OrderError(
    address from,
    string text,
    string reason
  );

  uint ordercount = 0;

  // store the proof for a student in the contract state

  function recordNameOrder(string memory name) private {
    listCustommer[ordercount] = name;
  }

  function recordTimestampOrder(uint date) private {
    listTimestamp[ordercount] = date;
  }

  function recordAddressOrder(address addr) private{
    listAddress[ordercount] = addr;
  }
  
  function recordOrder(Ordersdata memory data_order) private{
      listOrder[ordercount] = data_order;
  }
  
  // record a student name
  function GetOrder(string memory name) public payable {
      
    //T1 Saghett
    if (msg.value != 0.05 ether && hashing(name) == hashing("T1 Saghett")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.05 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //T1 Chocolate Cake
    if (msg.value != 0.08 ether && hashing(name) == hashing("T1 Chocolate Cake")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.08 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //T1 BBQ
    if (msg.value != 0.01 ether && hashing(name) == hashing("T1 BBQ")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.01 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //>T1 Blueberry Milkshake
    if (msg.value != 0.022 ether && hashing(name) == hashing(">T1 Blueberry Milkshake")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.022 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
     //T1 Water
    if (msg.value != 0.007 ether && hashing(name) == hashing("T1 Water")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.007 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
     //T1 Protein Drink
    if (msg.value != 0.099 ether && hashing(name) == hashing("T1 Protein Drink")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.099 ether to order");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }

   
    Ordersdata memory orderdata = Ordersdata(name, block.timestamp, msg.sender);
    recordOrder(orderdata);
    recordNameOrder(name);
    recordTimestampOrder(now);
    recordAddressOrder(msg.sender);
    ordercount++;

    
    //---fire the event---
   emit OrderAdded(msg.sender, name, now,
        hashingOrder(name, now, msg.sender));
    }
  
  // SHA256 for Integrity
  
  function hashing(string memory name) private 
  pure returns (bytes32) {
    return sha256(bytes(name));
  }

  function hashingOrder(string memory name, uint timestamp, address addr) private
  pure returns (bytes32) {
    return sha256(abi.encodePacked(name,timestamp,addr));
  }
  
  // get name
  function getName(uint index) public view returns (string memory) {
    return listCustommer[index];
  }

  // get timestamp
  function getTimestamp(uint index) public view returns (uint) {
    return listTimestamp[index];
  }
  
  // get address
  function getAddress(uint index) public view returns (address) {
    return listAddress[index];
  }
  
  //get countorder
  function getOrderCount() public view returns (uint){
    return ordercount;
  }
}