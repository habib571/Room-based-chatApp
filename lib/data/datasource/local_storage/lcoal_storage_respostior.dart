import 'package:hive_flutter/hive_flutter.dart';


class RoomsDataBase { 
List roomsList =[] ; 
final _mybox =Hive.box("mybox");   
void createInitialData() {
    roomsList = [
     [ "hello" , 'w7<b3-k7' ] ,
    ] ;
  }
// ignore: non_constant_identifier_names
void GetData() { 
  roomsList =_mybox.get("RoomsList") ;

} 
// ignore: non_constant_identifier_names
void Updatedatabase() { 
  _mybox.put("RoomsList", roomsList) ;
}
 


  
}

