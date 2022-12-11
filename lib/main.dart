

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/routing/router.dart'; 
import 'View/widgets/roompage/RoomBM_widget.dart';
import 'firebase_options.dart'; 
import 'package:hive/hive.dart' ;  
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:revi/View/widgets/roompage/RoomCard.dart';



void main() async{ 
 WidgetsFlutterBinding.ensureInitialized() ;  
 await Firebase.initializeApp(

  options: DefaultFirebaseOptions.currentPlatform,


 ) ;  
 await Hive.initFlutter() ; 
  var box = await Hive.openBox('mybox');
 
  
 
  
   runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
   
    
  
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.green,
      ),
  
      getPages: routes,
    );
  }
}

