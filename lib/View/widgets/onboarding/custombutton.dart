import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/onboarding_controller.dart'; 
class ButtonOnboarding extends GetView<OnboardingControllerImp> {
  const ButtonOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox( 
          height: 50,   
        
           child: MaterialButton(
            onPressed: () { 
              controller.next()  ;
            }  ,
            padding:const EdgeInsets.symmetric(horizontal: 100), 
            textColor: Colors.white,
            color: Colors.blue, 
            
            child:    const Text("continue", 
            style: TextStyle( 
              fontWeight: FontWeight.bold
            )
            )      
            ),
            
           
            
            
            );
  }
}