


import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:revi/model/chat-user.dart';

//import 'package:revi/routing/router_const.dart';
class AuthController  {  
  static final FirebaseFirestore firestore =FirebaseFirestore.instance ;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance; 
  static User get user =>firebaseAuth.currentUser!; 
  static FirebaseStorage storage = FirebaseStorage.instance;
 
 static  ChatUser me =  ChatUser(
    image: user.photoURL.toString(),
     name: user.displayName.toString()  ,
     email:  user.email.toString() ,
     id: user.uid
     ) ;


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
    return FirebaseAuth.instance.currentUser ;
  }  
   getProfilEmailImage()  {
    if(firebaseAuth.currentUser!.photoURL !=null) {
      return Image.network('$firebaseAuth.currentUser!.photoURL');
    } else {
      return const Icon(Icons.account_circle) ;
    }
   } 
  static Future<void> createUser()  async { 
    final chatUser =ChatUser(
      name: user.displayName.toString(),
       email: user.email.toString(),
        id:  user.uid , 
        image: user.photoURL.toString()
        );  
       return await  firestore 
        .collection('users')
        .doc(user.uid) 
        .set(chatUser.toJson()) ;
        


   } 
      static Future<bool> userExists() async {

    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }
 static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
    });
  } 

    static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb'); 
      
    } 
  
    );
   me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});


}  


static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .snapshots() ;
  }
}

   
