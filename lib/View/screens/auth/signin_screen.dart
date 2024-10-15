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
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // To track loading state
  ChatUser? chatUser;

  @override
  void initState() {
    super.initState();
    isUserExist();
  }

  isUserExist() async {
    Future.delayed(const Duration(seconds: 2), () async {
      if (AuthController.firebaseAuth.currentUser != null) {
        log('user exist');
        Get.off(() => Homepage());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
  }

  // Handles login button click
  _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthController.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } catch (e) {
        log("Login failed: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
              key: _formKey, // Assign form key
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
          ),
        ),
        if (_isLoading) // Show loading overlay if true
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  _header(context) {
    return Column(
      children: [
        Text("Welcome Back", style: poppinsBold.copyWith(fontSize: 40)),
        Text(
          "Enter your credential to login",
          style: poppinsRegular.copyWith(color: AppColors.secondaryTxtColor, fontSize: 16),
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
            hintStyle: poppinsMedium.copyWith(fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.accentColor,
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Enter a valid email";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: poppinsMedium.copyWith(fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.accentColor,
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            } else if (value.length < 6) {
              return "Password must be at least 6 characters long";
            }
            return null;
          },
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: ElevatedButton(
            onPressed: _login, // Call the login method
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text(
              "Login",
              style: poppinsBold.copyWith(color: Colors.white, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forgot password?",
        style: poppinsBold.copyWith(color: AppColors.primaryColor, fontSize: 13),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: poppinsSemiBold.copyWith(color: AppColors.secondaryTxtColor, fontSize: 13),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const Signup());
          },
          child: Text(
            "Sign Up",
            style: poppinsBold.copyWith(color: AppColors.primaryColor, fontSize: 14),
          ),
        )
      ],
    );
  }
}
