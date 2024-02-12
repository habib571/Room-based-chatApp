

class Room {
   Room( 
  {
    required this.token  , 
    required  this.roomname , 
    required this.image ,  
     this.isUserAdmin =false 

     
  }
   ) ; 
   
    late final String token ;  
    late final String roomname ;  
    late final String image ;  
     bool  isUserAdmin = false;
      Room.fromJson(Map<String,dynamic> json) {
        roomname = json['roomname']?? '' ;  
        token = json['token']?? '' ;    
        image = json['image'] ?? '' ; 
        isUserAdmin =json['isUserAdmin'] ;
     

      
      } 
    Map<String , dynamic> toJson() { 
       final data = <String, dynamic>{} ; 
       data['roomname']=  roomname ; 
       data['token'] = token ; 
       data['image'] = image ;  
       data['isUserAdmin'] = isUserAdmin ;  

      
       return data ; 

    }

 } 