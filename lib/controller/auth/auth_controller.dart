


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:revi/model/chat-user.dart';

//import 'package:revi/routing/router_const.dart';
class AuthController  {  
  static final FirebaseFirestore firestore =FirebaseFirestore.instance ;
  
 static final FirebaseAuth firebaseAuth = FirebaseAuth.instance; 
   static User get user =>firebaseAuth.currentUser!;

  static Future<dynamic> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }  
   getProfilEmailImage()  {
    if(firebaseAuth.currentUser!.photoURL !=null) {
      return Image.network('$firebaseAuth.currentUser!.photoURL');
    } else {
      return const Icon(Icons.account_circle) ;
    }
   } 
  static Future<void> createUser(String name)  async { 
    final chatUser =ChatUser(
      name: name,
       email: user.email.toString(),
        id:  user.uid
        ); 
       return await  firestore 
        .collection('users')
        .doc(user.uid) 
        .set(chatUser.toJson()) ;
        


   }


} 


   
