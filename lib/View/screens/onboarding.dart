import 'package:flutter/material.dart';  

import 'package:revi/View/widgets/onboarding/controller.dart';
import 'package:revi/View/widgets/onboarding/custombutton.dart';
import 'package:revi/View/widgets/onboarding/slider.dart';
import 'package:revi/controller/onboarding_controller.dart'; 
import 'package:get/get.dart';
 class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) { 
    Get.put(OnboardingControllerImp()) ;
    return const Scaffold( 
      body: SafeArea(
        child:  Column(children: [ 
          Expanded(  
            flex: 2,
            child: SliderOnboarding()    
            
    ),  
    
    Expanded( 
      flex: 1,
      child:  Column( 
        children: [  
          ControllerOnboarding(),
        SizedBox( 
          height: 50,
        ),
        ButtonOnboarding()
        ]) 
      
      )
    
        ]
      )));
  }
}