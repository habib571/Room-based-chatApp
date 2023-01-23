import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/roomsPage.dart';

import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/model/chat-user.dart';
import 'package:revi/routing/router.dart';
import 'package:revi/routing/router_const.dart'; 

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key , 
  required this.user 
  
  
  }); 
  final ChatUser user;
 
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      
      body:  Center( 
     child: Column(children: [ 
     const  SizedBox( 
        height: 50,
      ),
      GestureDetector( 
       child: const Text("Signout"), 
       onTap: () {
         AuthController.signOut() ;  
         Get.toNamed(Approuter.onboarding) ;
       },

     ) , 
     ElevatedButton(
      onPressed: (){

        Get.toNamed(Approuter.rooms) ;
      }, 
      child: const Text("go to ")
    
     )
   ]) ) );
  }
}