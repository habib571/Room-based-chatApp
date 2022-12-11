




import 'package:get/get.dart'; 
import 'package:revi/View/screens/auth/signin_screen.dart';
import 'package:revi/View/screens/onboarding.dart';
import 'package:revi/View/screens/Roompages/roomsPage.dart';
import 'package:revi/home.dart';
//import 'package:revi/middleware/middlware.dart';  
import 'package:revi/routing/router_const.dart'; 
import 'package:revi/View/screens/auth/signup screen.dart';
import 'package:revi/splash.dart';
 
 List<GetPage<dynamic>>? routes =[   
  GetPage(name: "/", page:() => const SplashScreen()) ,

  GetPage(name: Approuter.login, page:() => const SignIn() ) ,
  GetPage(name: Approuter.signup, page: ()=> const Signup())   ,
  GetPage(name: Approuter.home, page: ()=>const home()) ,
  GetPage(name: Approuter.onboarding, page: ()=> const Onboarding() )  ,
  GetPage(name: Approuter.rooms, page: () => RoomPage() ) 
  
 ] ;

