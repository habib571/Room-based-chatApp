
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 



abstract class RoomPageController extends GetxController{
createroom(); 
addroom(String name,token) ; 

//late TextEditingController roomname;
final roomname=TextEditingController();

}
class RoomPageControllerImp extends RoomPageController{
  GlobalKey<FormState> formstate= GlobalKey<FormState>();
  @override 
addroom(String name ,token ) {  
  DocumentReference Rname = FirebaseFirestore.instance.collection('rooms').doc('roomname') ;  
   DocumentReference tokens = FirebaseFirestore.instance.collection('rooms').doc('token') ;  
    Rname.set({ 
      'roomname' :name 
    }).then((value) => print("added"))
    .catchError((error) => print("Failed to add user: $error")); 
    tokens.set({ 
      'token' :token
    }).then((value) => print("added"))
    .catchError((error) => print("Failed to add user: $error"));



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

    super.dispose();
  } 
}