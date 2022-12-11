import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/onboarding_controller.dart';  
import 'package:revi/data/datasource/static/static.dart';
class ControllerOnboarding extends StatelessWidget {
  const ControllerOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingControllerImp>(builder: (controller) => 
          
          Row( 
            
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
          ...List.generate(onboardinglist.length, (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 900) ,
            width: 8,
            height: 8,  
            margin: const EdgeInsets.only(right: 5) ,
            decoration:  BoxDecoration( 
              color: controller.currentpage==index?const  Color.fromARGB(255, 219, 217, 217) :const Color.fromARGB(255, 43, 150, 236),
              borderRadius: BorderRadius.circular(10)

          )))
          ]
            ) 
        
     ) ;
        
        
  }
}