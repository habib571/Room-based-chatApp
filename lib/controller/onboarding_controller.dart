import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; 
import 'package:revi/data/datasource/static/static.dart';
import 'package:revi/routing/router_const.dart';


abstract class OnboardingController extends GetxController { 
  next() ; 
 onPagechanged(int index) ;



} 
class OnboardingControllerImp extends OnboardingController {    

  late PageController pageController ; 
  int currentpage =0 ; 
 // Myservices myservices = Get.find();
  @override
   next() { 
    currentpage++ ; 
    if (currentpage>onboardinglist.length-1)  { 
     // myservices.sharedPreferences.setString("onbaording", "1") ;
      Get.offAllNamed(Approuter.login) ;
    } else {
   pageController.animateToPage(currentpage, duration: const Duration(milliseconds: 900), curve: Curves.easeInOut) ; 
    }
  }

 
  @override
   onPagechanged(int index) { 
    currentpage =index ; 
    update() ; 
  
} 
@override   
void onInit() {
  pageController =PageController() ;
  super.onInit() ; 
}

 }