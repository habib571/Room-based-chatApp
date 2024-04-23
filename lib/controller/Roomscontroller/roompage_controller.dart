import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revi/model/Room.dart';
import '../../model/token.dart';
import '../auth/auth_controller.dart';

abstract class RoomPageController extends GetxController {
  addroom(String name, token);
  addtoMyrooms(String name, token, bool admin);
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomInfo(Room room);
  Future<void> deleteRoom(Room room);

  Future<void> updateRoominfo(Room room, String tk, name);

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyrooms();
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo();
  Future<void> join();
  bool checkToken();
  Future<void> updateRoomPicture(File file, Room room);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
//late TextEditingController roomname;
  final roomname = TextEditingController();
  final enteredtoken = TextEditingController();
  final verifToken = TextEditingController();
}

class RoomPageControllerImp extends RoomPageController {  
  @override
  void onInit() { 
  
     
    super.onInit();
  }



  User get user => AuthController.currentUser()!; 


  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future<void> create() async {
    final name = roomname.text;
    //Navigator.of(context).pop(name);
    final passwod = GeneratedToken.genToken();
    roomname.clear();
    addroom(name, passwod);
    addtoMyrooms(name, passwod, true);
    update();
  }

  @override
  Future<void> addroom(String name, token) async {
    final room = Room(token: token, roomname: name, image: '');

    await firestore.collection('rooms').add(room.toJson());
  }

  @override
  Future<void> addtoMyrooms(String name, token, bool admin) async {
    final room = Room(
        isUserAdmin: admin ? true : false,
        token: token,
        roomname: name,
        image: '');
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .add(room.toJson());
  }

  @override
  getMyrooms() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .snapshots();
  }

  @override
  Future<void> join() async {
    final querySnapshot = await firestore.collection('rooms').get();

    for (var doc in querySnapshot.docs) {
      if (verifToken.text == doc['token']) {
        addtoMyrooms(
            doc['roomname'].toString(), doc['token'].toString(), false);
      }
    }

    print('hhhhhhhhhh');
  }

  @override
  bool checkToken() {
    bool check = false;

    firestore.collection('rooms').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (verifToken.text == doc['token']) {
          check = !check;
          print(check);
        }
      }
    });
    return check;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomInfo(Room room) {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .where('roomname', isEqualTo: room.roomname)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() {
    return firestore.collection('users').doc(user.uid).snapshots();
  }

  @override
  Future<void> deleteRoom(Room room) async {
    final messagequery = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .where('token', isEqualTo: room.token)
        .get(); 
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messagequery.docs) {
      batch.delete(docSnapshot.reference);
    }
    await batch.commit();
    update();
  }

  @override
  Future<void> updateRoomPicture(File file, Room room) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('Room_profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    final image = await ref.getDownloadURL();
    final messagequery = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .where('token', isEqualTo: room.token)
        .get();
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messagequery.docs) {
      batch.update(docSnapshot.reference, {'image': image});
    }
    await batch.commit();
    update();
  }

  @override
  Future<void> updateRoominfo(Room room, String tk, name) async {
    final messagequery = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myrooms')
        .where('token', isEqualTo: room.token)
        .get();
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messagequery.docs) {
      batch.update(docSnapshot.reference, {'roomname': name, 'token': tk});
    }
    await batch.commit();
    update();
  }

  @override
  void dispose() {
    roomname.dispose();
    enteredtoken.dispose();
    verifToken.dispose();
    super.dispose();
  }
}
