
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/routing/router_const.dart';
import 'package:revi/view/widgets/auth/emailField.dart';

import 'package:flutter/material.dart';
import 'package:revi/view/widgets/auth/passwordFiled.dart'; 
import 'package:revi/view/widgets/auth/myTextButton.dart';  


import 'package:get/get.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}):super(key: key);

 

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {  
late TextEditingController emailcontroller =TextEditingController() ; 
late TextEditingController passwordcontroller =TextEditingController() ; 
late TextEditingController usernameC =TextEditingController() ;
  bool passwordVisibility = true;   
 
  @override 
  void dispose() {
    emailcontroller.dispose() ;
    passwordcontroller.dispose() ;
    usernameC.dispose() ;
    super.dispose() ;
  } 
  @override
  Widget build(BuildContext context) { 


   
    
    return Scaffold(   
      appBar: AppBar( 
        backgroundColor: Colors.white,  
       
        title: const Text('LogIn' ,style: TextStyle(fontSize: 25 ,color: Colors.black ,fontWeight: FontWeight.bold)), 
        centerTitle: true, 
        
        
      ),
      
      body:  
      
        SafeArea(  
        
        child: CustomScrollView(
          slivers: [ 
            SliverFillRemaining(  
              hasScrollBody: false, 
              child: Padding(
                padding:  const EdgeInsets.symmetric( 
                  horizontal: 30
                ) , 
                child: Column(  
                
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [    
                    const SizedBox(height: 50), 
                    
                   
                  const Center(
                    child: Image(image: AssetImage("assets/rev.png"), 
                     width: 180 ,
                     height: 180,
                     alignment:Alignment.center,),
                  ),  
                  const  SizedBox(height: 100) ,
                  MyTextField( 
                      label: "Username",
                      hintText: 'Enter your Username',
                      inputText: TextInputType.name,
                      textEditingController:usernameC
                        ) , 
                        const SizedBox( 
                          height: 20,
                        ) ,
        
                           
                           MyTextField( 
                            label: "E-mail",
                            hintText: 'Enter your email',
                             inputText: TextInputType.emailAddress,
                              textEditingController: emailcontroller
                            
                              ), 
                            const  SizedBox(  
                              height: 13,
                            ), 
                          Mypasswordfield(  
                            label: 'Password',
                            hintText: 'Enter your password', 
                            isPasswordVisible: passwordVisibility,
                            ontap: () {  setState(() {
                              passwordVisibility = !passwordVisibility ;
                            });
                            
                            },
                              textEditingController: passwordcontroller 
                              ),  
                              const SizedBox(height: 10),  
                              GestureDetector(  
                                onTap: (() {
                                  
                                } 
                                ) ,
                                child: const  Text( 
                                  "Forget password",
                                  style: TextStyle( 
                                    fontWeight: FontWeight.bold, 
                                    color: Colors.grey, 
                                    fontSize: 15, 

                                  ) ,
                                 
                                  

                              
                              )), 
                                 const SizedBox(height: 40),  

                              MyTextButton(buttonName: 'LogIn',
                               ontap:(){   
                                 _signIn() ;
                                
                               
                             
                                 //AuthController.instance.goTohome ;
                               },
                                textcolor: Colors.white,
                                 bgcolor: Colors.blue,
                                 ),
                             const SizedBox( 
                                height: 13,
                              ),  
                              
                              
                                
                                 Row( 
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [  
                                    
                                   
                                    const Text("Don't have an account?" , 
                                    style: TextStyle( 
                                      color: Colors.black , 
                                      fontSize: 15

                                    ),
                                    ), 
                                    GestureDetector( 
                                      onTap: (() { 
                                      Get.toNamed(Approuter.signup) ;
                                      }) , 
                                      child:const  Text("Register", 
                                      style: TextStyle( 
                                        fontSize: 15, 
                                        color: Colors.blue, 
                                        fontWeight: FontWeight.bold
                                      )),

                                    )
                                  ],
                                ),
                              
                                


                            




                  ],


                ),

              
                ),







            )
          ],
        ),

       ),


       );
   
     
  } 
  _signIn() async {
    var email = emailcontroller.text.trim();
    var pw = passwordcontroller.text.trim();
    var usern = usernameC.text.trim() ;

   if (email.isEmpty || pw.isEmpty) {
      await showOkAlertDialog(
        context: context,
        message: 'Check your email or password',
      );
      return;
    }

    var obj =  await AuthController.signIn(email, pw);

    if (obj is User) { 
     await   AuthController.createUser(usern).then((value) { 
      Get.toNamed(Approuter.home) ; 
    });
      
    } else {
      await showOkAlertDialog(
        context: context,
        message: obj,
      );
    }
  } 
}

