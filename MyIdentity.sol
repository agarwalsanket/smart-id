pragma solidity ^0.4.21;


contract MyIdentity{
    
    struct profileAttributes{
        address profile_owner_Address;
        bytes32 fullName;
        bytes32 dob;
        uint age;
        bytes32 gender;
        uint mobileNo;
        bytes32 mailingAddress;
        bytes32 permanentAddress;
        bytes32 emailId;
    }
    
    
    
    mapping (address => uint256) public lastProfileIndex;
    mapping (address => mapping(uint256 => profileAttributes)) public receivedProfile;
    mapping (address => profileAttributes) public profiles;
    
    
     event ChangeNotification(address indexed sender, bytes32 notificationMsg);
    
     event ProfileSetting(address profile_owner_Address, bytes32 fullName, bytes32 dob, uint age, bytes32 gender, uint mobileNo, bytes32 mailingAddress, bytes32 permanentAddress, bytes32 emailId);
    
    function sendEvent(bytes32 _notification) internal returns(bool) {
        ChangeNotification(msg.sender, _notification);
        return true;
    }
    
   /* function setProfile1
    (
        bytes32 _name, 
        bytes32 _dob

        ) public{
        profiles[msg.sender].profile_owner_Address = msg.sender;
        profiles[msg.sender].fullName = _name;
        profiles[msg.sender].dob = _dob;
   
        
        
    }
    
  
    function setProfile2
    (
        uint _age, 
        bytes32 _gender,
        uint _mobile

        ) public{
        profiles[msg.sender].age = _age;
        profiles[msg.sender].gender = _gender;
        profiles[msg.sender].mobileNo = _mobile;
        
        //ProfileSetting(msg.sender, _name, _dob, _age, _gender, _mobile, _mailing, _permanent, _email);
    }
    
     function setProfile3
    (
        bytes32 _mailing,
        bytes32 _permanent,
        bytes32 _email
        ) public{
        profiles[msg.sender].mailingAddress = _mailing;
        profiles[msg.sender].permanentAddress = _permanent;
        profiles[msg.sender].emailId = _email;
        var p = profiles[msg.sender];  //temporarily storing the profile
        ProfileSetting(msg.sender,p.fullName,p.dob,p.age,p.gender,p.mobileNo,p.mailingAddress,p.permanentAddress,p.emailId);
    }
    */
     function setProfile
    (
        bytes32 _name, 
        bytes32 _dob, 
        uint _age,
        bytes32 _gender,
        uint _mobile,
        bytes32 _mailing,
        bytes32 _permanent,
        bytes32 _email
        ) {
        profiles[msg.sender].profile_owner_Address = msg.sender;
        profiles[msg.sender].fullName = _name;
        profiles[msg.sender].dob = _dob;
        profiles[msg.sender].age = _age;
        profiles[msg.sender].gender = _gender;
        profiles[msg.sender].mobileNo = _mobile;
        profiles[msg.sender].mailingAddress = _mailing;
        profiles[msg.sender].permanentAddress = _permanent;
        profiles[msg.sender].emailId = _email;
        
        ProfileSetting(msg.sender, _name, _dob, _age, _gender, _mobile, _mailing, _permanent, _email);
        
    }
    
    function getProfile() public constant returns
    (   address,
        bytes32, 
        bytes32, 
        uint,
        bytes32,
        uint,
        bytes32,
        bytes32,
        bytes32
        ){
        return
        (
            profiles[msg.sender].profile_owner_Address,
            profiles[msg.sender].fullName,
            profiles[msg.sender].dob,
            profiles[msg.sender].age,
            profiles[msg.sender].gender,
            profiles[msg.sender].mobileNo,
            profiles[msg.sender].mailingAddress,
            profiles[msg.sender].permanentAddress,
            profiles[msg.sender].emailId
            );
    }
    
    
    
    function sendProfile(address _to, bool[] _send){
        if(_send[0]){ receivedProfile[_to][lastProfileIndex[_to]].fullName = profiles[msg.sender].fullName; }
        if(_send[1]){ receivedProfile[_to][lastProfileIndex[_to]].dob = profiles[msg.sender].dob; }
        if(_send[2]){ receivedProfile[_to][lastProfileIndex[_to]].age = profiles[msg.sender].age; }
        if(_send[3]){ receivedProfile[_to][lastProfileIndex[_to]].gender = profiles[msg.sender].gender; }
        if(_send[4]){ receivedProfile[_to][lastProfileIndex[_to]].mobileNo = profiles[msg.sender].mobileNo; }
        if(_send[5]){ receivedProfile[_to][lastProfileIndex[_to]].mailingAddress = profiles[msg.sender].mailingAddress; }
        if(_send[6]){ receivedProfile[_to][lastProfileIndex[_to]].permanentAddress = profiles[msg.sender].permanentAddress; }
        if(_send[7]){ receivedProfile[_to][lastProfileIndex[_to]].emailId = profiles[msg.sender].emailId; }
        
        lastProfileIndex[_to]++;
        sendEvent("Profile sent!");
    }
    
    function readReceivedProfile2() constant returns
    (   address,
        uint,
        bytes32,
        bytes32,
        bytes32
        ) {
            return( msg.sender,
                    receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].mobileNo,
                    receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].mailingAddress,
                    receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].permanentAddress,
                    receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].emailId
                    );
        }
    
    function readReceivedProfile1() constant returns
    (   
        bytes32,
        bytes32,
        uint,
        bytes32
    ) {
      return(
          receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].fullName,
          receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].dob,
          receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].age,
          receivedProfile[msg.sender][lastProfileIndex[msg.sender]-1].gender
          ); 
    }
    
}