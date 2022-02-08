pragma solidity ^0.5.0;

contract StructStorage {

    uint256 public s = 1; 
    uint256 public c;
    uint256 public t=1;
    mapping (address => uint) balances;

    function fundaddr(address addr) public{
        balances[addr] = 2000;
    }

        function sendCoin(address receiver, uint amount, address sender) public returns(bool sufficient){
        
        
        if (balances[sender] < amount) 
        return false;
        
        balances[sender] -= amount;
        balances[receiver] += amount;
        
                        
        return true;
        
    }

    function getBalance(address addr) view public returns(uint){
        return balances[addr];
    }
struct farmer {
   
    bytes fid;
    bytes32 fname;
    bytes32 loc;
    bytes32 crop;
    uint256 contact;
    uint quantity;
    uint exprice;//期望价格
}

struct lot {

    bytes lotno;//批号
    bytes grade;
    uint mrp;//物资需求计划
    bytes32 testdate;
    bytes32 expdate;//期望日期
}

address public tester;
address owner;

mapping (bytes => farmer) f1;//农民字节码到农民结构体的映射
farmer[] public fm;

mapping (bytes => lot) l1;//批次字节码到批次结构体的映射
lot[] public l;



function produce(bytes memory id, bytes32 name, bytes32 loc, bytes32 cr, uint256 con, uint q, uint pr) public{
               
        StructStorage.farmer memory fnew = farmer(id,name,loc,cr,con,q,pr);//注册一个新农民
        f1[id] = fnew;
        fm.push(fnew);
        s++;
  
}
    
 function getproduce(bytes memory j) public view returns(bytes memory,bytes32,bytes32,bytes32,uint256,uint,uint) {
        return (f1[j].fid,f1[j].fname,f1[j].loc,f1[j].crop,f1[j].contact,f1[j].quantity,f1[j].exprice);//农民生产
    }
 function quality(bytes memory ll, bytes memory g, uint256 p, bytes32 tt, bytes32 e) public{//批次信息
    
        StructStorage.lot memory lnew=lot(ll,g,p,tt,e);
        l1[ll]=lnew;
        l.push(lnew);
        t++;
  
 }  
 function getquality(bytes memory k) public view returns(bytes memory,bytes memory,uint,bytes32,bytes32) {//获取批次质量
     return(l1[k].lotno,l1[k].grade,l1[k].mrp,l1[k].testdate,l1[k].expdate);
     
 }
}
