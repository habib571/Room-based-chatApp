 import 'package:flutter/cupertino.dart';

class Room {
   Room( 
  {
    required this.token  , 
    required  this.roomname
  }
   ) ; 
   
    late final String token ;  
    late final String roomname ; 
      Room.fromJson(Map<String,dynamic> json) {
        roomname = json['roomname']?? '' ;  
        token = json['token']?? '' ;   
     

      
      } 
    Map<String , dynamic> toJson() { 
       final data = <String, dynamic>{} ; 
       data['roomname']=  roomname ; 
       data['token'] = token ;  
      
       return data ; 

    }

 } 