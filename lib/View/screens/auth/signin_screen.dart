import 'dart:developer';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/home.dart';
import 'package:revi/View/screens/auth/signup%20screen.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/model/chatuser.dart';

import '../../../controller/auth/auth_controller.dart';
import '../../../helper/dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key, 
 
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
 ChatUser? chatUser ;
 /* @override
  void initState() {
    super.initState(); 
   
  // isUserExist() ;
    //for auto triggering animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }*/
 isUserExist() async {   
       Future.delayed(const Duration(seconds: 2) , () async{
       if( AuthController.firebaseAuth.currentUser !=null ) {
      log('user exist') ;
       Get.off(()=>  
            Homepage());
       
    } 
    else { 
      Get.off(()=>const LoginScreen()) ;
    }
     }) ;
    
 }
  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await AuthController.userExists())) {
            Get.off(()=>  
            Homepage());
        } else {
           /*  await AuthController.createUser().then((value) {
                  Get.off(()=>   Homepage()) ;
          });*/
        }
        }
      } );
    
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await AuthController.firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      // ignore: use_build_context_synchronously
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

 final TextEditingController _emailController = TextEditingController() ;
  final TextEditingController _passwordController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
   final  mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    );

  }

  _header(context) {
    return  Column(
      children: [
        Text(
          "Welcome Back",
          style: poppinsBold.copyWith(fontSize: 40)
        ),
        Text(
            "Enter your credential to login" ,
          style: poppinsRegular.copyWith(color: AppColors.secondaryTxtColor , fontSize: 16),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "Email",
              hintStyle: poppinsMedium.copyWith(fontSize: 13) ,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none
              ),
              fillColor: AppColors.accentColor ,
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: poppinsMedium.copyWith(fontSize: 13) ,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: AppColors.accentColor ,
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: ElevatedButton(
            onPressed: () {
              AuthController.signIn(_emailController.text, _passwordController.text) ;
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primaryColor
            ),
            child: Text(
              "Login",
              style: poppinsBold.copyWith(color: Colors.white ,fontSize: 15)
            ),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child:  Text(
        "Forgot password?",
        style: poppinsBold.copyWith(color: AppColors.primaryColor , fontSize: 13)
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
            "Dont have an account? " ,
          style: poppinsSemiBold.copyWith(color: AppColors.secondaryTxtColor ,fontSize: 13 ),
        ),
        TextButton(
            onPressed: () {
              Get.to(()=>const Signup()) ;
            },
            child:  Text(
              "Sign Up",
              style:  poppinsBold.copyWith(color: AppColors.primaryColor ,fontSize: 14 ),
            )
        )
      ],
    );
  }
}

