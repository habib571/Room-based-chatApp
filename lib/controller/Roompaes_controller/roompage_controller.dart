
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:revi/model/Room.dart';

import '../auth/auth_controller.dart';


abstract class RoomPageController extends GetxController{
createroom(); 
addroom(String name,token) ;   
addtoMyroomsAdmin(String name ,token) ; 
addtoMyroomsJoined(String name ,token) ;  
Stream<QuerySnapshot<Map<String,dynamic>>> getRoomInfo(Room room) ;

deleteRoom() ;
Stream<QuerySnapshot<Map<String,dynamic>>>getRoomAdmin( ) ;  
Stream<QuerySnapshot<Map<String,dynamic>>>getRoomJoined() ;     
gettVerif(String verifT) ; 
bool checkToken(bool check) ;




 FirebaseFirestore firestore = FirebaseFirestore.instance ;  
 


//late TextEditingController roomname;
final roomname=TextEditingController(); 
final enteredtoken = TextEditingController() ; 
final verifToken =TextEditingController() ;

}
class RoomPageControllerImp extends RoomPageController{ 
  User? get user =>AuthController.currentUser(); 
  GlobalKey<FormState> formstate= GlobalKey<FormState>();
  @override 
 Future<void> addroom(String name ,token )  async {   
  final room =Room(
    token: token, 
    roomname: name
    );


   await  firestore
         .collection('rooms')
         .add(room.toJson()) ;
    
} 


  @override 
   Future<void> addtoMyroomsAdmin(String name, token)  async{ 
    final room =Room(
    token: token, 
    roomname: name
    ); 
    await firestore 
       .collection('users')
       .doc(user!.uid)
       .collection('myroomsAdmin')
       .add(room.toJson()) ;

    
    
  }
  @override 
   Future<void> addtoMyroomsJoined(String name, token)  async { 
    final room =Room(
    token: token, 
    roomname: name
    ); 
    await firestore 
       .collection('users')
       .doc(user!.uid)
       .collection('myroomsJoined') 
       .add(room.toJson()) ;

    
    
  } 
  @override 
   getRoomAdmin() {   

    return firestore 
           .collection('users') 
           .doc(user!.uid) 
           .collection('myroomsAdmin')
           
           
           .snapshots();
   
  }  
  @override 
  getRoomJoined() { 
    return firestore 
           .collection("users") 
           .doc(user!.uid)
           .collection('myroomsJoined')
           .snapshots(); 

  } 
  @override
  Future<void> gettVerif(String verifT)  async{   
       
      firestore
    .collection('rooms')
     .get()
    .then((QuerySnapshot querySnapshot) { 
    for (var doc in querySnapshot.docs) {    


      if(verifT==doc['token']) 
      {     
        addtoMyroomsJoined(doc['roomname'].toString(), doc['token'].toString()) ; 
      } 
    }})  ;
   
    
 
   }  
   @override 
   bool checkToken( bool check) { 
     check =false ;
 
      firestore
    .collection('rooms')
     .get()
    .then((QuerySnapshot querySnapshot) { 
    for (var doc in querySnapshot.docs) {    

      if(verifToken.text==doc['token']) {     
        check =!check ;
      }  
     
    }})  ; 
    return check ;
  } 
  @override 
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomInfo(Room room) { 
    return firestore
    .collection('rooms')
    .where('roomname' ,isEqualTo: room.roomname) 
    .snapshots() ;

  }
 
 @override 
 deleteRoom() {
 }



  @override
  createroom() {
  var formdata=formstate.currentState;

   
  }
@override  
 
  void onInit() {


    super.onInit();
  }
  @override
  void dispose() {
roomname.dispose(); 
enteredtoken.dispose() ;  
verifToken.dispose() ;


    super.dispose();
  }
  
   
}