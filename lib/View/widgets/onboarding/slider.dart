import 'package:flutter/material.dart';
import 'package:revi/controller/onboarding_controller.dart';  
import 'package:revi/data/datasource/static/static.dart'; 
import 'package:get/get.dart';
class SliderOnboarding extends GetView<OnboardingControllerImp> {
  const SliderOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(   
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPagechanged(value) ;
      },
        itemCount: onboardinglist.length,
        itemBuilder:(context, i) =>  

           
           Column(  
          
          children: [  
          
           const SizedBox(
            height: 50,
           ),
            Text(
              onboardinglist[i].title , 
              style: const TextStyle( 
                fontWeight: FontWeight.bold ,
                fontSize: 30, 


              ), 
              textAlign: TextAlign.center,
             
            
            ),  
               const SizedBox( 
                height: 50,


               ),
            Image.asset(onboardinglist[i].image,
            height: 200, 
            width: 200,
            
            ) ,  
            const SizedBox(
              height: 50,
            ), 
            Container(  
            
              width: double.infinity, 
              alignment :Alignment.center ,
            child:Text(
              onboardinglist[i].body,
              style: const TextStyle( 
                fontSize: 20,
                color: Colors.grey

              ),  
              textAlign: TextAlign.center,


              ) 
            )

          ],
        )
        
        
      );
  }
}