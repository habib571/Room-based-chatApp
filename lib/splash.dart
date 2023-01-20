import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/routing/router_const.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: AuthController.initializeFirebase(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User? user =AuthController.currentUser();
          if (user != null) {
            Future.delayed(Duration.zero, () async {
             Get.toNamed(Approuter.home) ;
            });
          } else {
            return _getScreen(context);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
  _getScreen(BuildContext context) {
    return 
    Center(child: 
    TextButton( 
                 
                    
                  onPressed: () { 
                  Get.offNamed(Approuter.login) ;
                  }  ,
                  
                  child: const Text(
                    'GET STARTED',
                      style: TextStyle( 
                        fontSize: 30 , 
                        color: Colors.black
                      ),
                  ),
                )
    
  ); }}