import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/routing/router_const.dart'; 

// ignore: camel_case_types
class home extends StatelessWidget {
  const home({super.key});

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
      } ,
      child: const Text("go to ")
    
     )
   ]) ) );
  }
}