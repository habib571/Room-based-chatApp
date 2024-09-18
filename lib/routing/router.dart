

import 'package:get/get.dart';
import 'package:revi/home.dart';
import 'package:revi/routing/router_const.dart'; 

 List<GetPage<dynamic>>routes =[   

  //GetPage(name: "/", page:() => const SplashScreen() ) ,
 // GetPage(name: Approuter.login, page:() => const  SignIn() ) ,
  //GetPage(name: Approuter.signup, page: ()=> const Signup())   ,
  GetPage(name: Approuter.home, page: ()=> const home()) ,
 // GetPage(name: Approuter.rooms, page: () => const Homepage())  , 


  
  
 ] ;

