/* import 'package:flutter/material.dart';
 
import 'package:get/get.dart';
import 'package:revi/routing/router_const.dart';
import 'package:revi/services/services.dart'; 
 class Middleware extends GetMiddleware {  
  @override
  int? get priority =>1;
Myservices myservices=Get.find();
  @override
RouteSettings? redirect(String? route) {

    if(myservices.sharedPreferences.getString("onboarding")=="1") {
      return const RouteSettings(name: Approuter.login) ;
    }
   return super.redirect(route) ;

  }
    
 }*/