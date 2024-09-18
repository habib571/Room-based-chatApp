import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/auth/signin_screen.dart';
import 'package:revi/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/styles.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameC = TextEditingController();

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController passwordConfirmC = TextEditingController();
  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    passwordConfirmC.dispose();

    super.dispose();
  }

  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  Text(
                    "Sign up",
                    style: poppinsBold.copyWith(fontSize: 40)
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create your account",
                    style: poppinsRegular.copyWith(color: AppColors.secondaryTxtColor , fontSize: 16)
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameC,
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: AppColors.accentColor ,
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailC,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: poppinsMedium.copyWith(fontSize: 13) ,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: AppColors.accentColor ,
                        filled: true,
                        prefixIcon: const Icon(Icons.email)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordC,
                    decoration: InputDecoration(
                      hintStyle: poppinsMedium.copyWith(fontSize: 13) ,
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor:AppColors.accentColor ,
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordConfirmC,
                    decoration: InputDecoration(
                      hintStyle: poppinsMedium.copyWith(fontSize: 13) ,
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: AppColors.accentColor ,
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70) ,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthController.signUp(emailC.text.trim(),
                        passwordC.text.trim(), usernameC.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primaryColor
                  ),
                  child:  Text(
                    "Sign up",
                    style: poppinsBold.copyWith(color: Colors.white ,fontSize: 15)
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?" ,  style: poppinsSemiBold.copyWith(color: AppColors.secondaryTxtColor ,fontSize: 13 ),),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child:  Text(
                        "Login",
                          style:  poppinsBold.copyWith(color: AppColors.primaryColor ,fontSize: 14
                      ))
                  )]
              )
            ],
          ),
        ),
      ),
    );
  }
}
