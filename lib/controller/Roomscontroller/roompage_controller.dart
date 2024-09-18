import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revi/model/Room.dart';
import '../../model/chatuser.dart';
import '../../model/token.dart';
import '../auth/auth_controller.dart';

abstract class RoomPageController extends GetxController {
  addroom(String name, token, String imgUrl);
  addtoMyrooms(String name, token, bool admin, String imgUrl);
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomInfo(Room room);
  Future<void> deleteRoom(Room room);

  Future<void> updateRoominfo(Room room, String tk, name);

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyrooms();
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo();
  Future<void> join();
  bool checkToken();
  Future<void> updateRoomPicture(File file, Room room);
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomUsers(String token) ;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
//late TextEditingController roomname;
  final roomname = TextEditingController();
  final enteredtoken = TextEditingController();
  final verifToken = TextEditingController();
  String? imageUrl;
}

List<ChatUser> users = [];

class RoomPageControllerImp extends RoomPageController {
  User get user => AuthController.currentUser()!;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future<void> create() async {
    String image = '';
    final name = roomname.text;
    //Navigator.of(context).pop(name);
    final passwod = GeneratedToken.genToken();
    roomname.clear();
    if (imageUrl != null) {
      final file = File(imageUrl!);
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
      image = await ref.getDownloadURL();
    }

    addroom(name, passwod, image);
    addtoMyrooms(name, passwod, true, image);
    update();
  }

  @override
  Future<void> addroom(String name, token, String imgUrl) async {
    final room = Room(token: token, roomname: name, image: imgUrl);
    ChatUser chatUsr = await AuthController.getCurrentUser(user.uid);

    await firestore.collection('rooms').doc(token).set(room.toJson());
      firestore.collection('rooms').doc(token).collection('chatUsers').add(chatUsr.toJson()) ;
  }

  @override
  Future<void> addtoMyrooms(
      String name, token, bool admin, String imgUrl) async {
    final room = Room(
        isUserAdmin: admin ? true : false,
        token: token,
        roomname: name,
        image: imgUrl);
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
        .orderBy('lastMsgTime', descending: true)
        .snapshots();
  }

  markAsSeen(String toId) async {
    final messages = await firestore
        .collection('messages')
        .where('fromId', isEqualTo: user.uid)
        .where('toId', isEqualTo: toId)
        .where('isRead', isEqualTo: false)
        .get();
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messages.docs) {
      batch.update(docSnapshot.reference, {'isRead': true});
    }
    await batch.commit();
    update();
  }

  int count = 0;
  Future<int> countUnReadMessages(Room room) async {
    int count = 0;
    final messages = await firestore
        .collection('messages')
        .where('fromId', isEqualTo: room.token)
        .where('toId', isEqualTo: user.uid)
        .get();
    for (var element in messages.docs) {
      count = element.data() as int;
    }
    update();
    return count;
  }

  @override
  Future<void> join() async {
    final querySnapshot = await firestore.collection('rooms').get();
    ChatUser chatUsr = await AuthController.getCurrentUser(user.uid);
    for (var doc in querySnapshot.docs) {
      if (verifToken.text == doc['token']) {
        addtoMyrooms(doc['roomname'].toString(), doc['token'].toString(), false,
            doc['image']) ;
        firestore.collection('rooms').doc(doc['token']).collection('chatUsers').add(chatUsr.toJson()) ;
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
        .where('token', isEqualTo: room.roomname)
        .get();
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messagequery.docs) {
      batch.delete(docSnapshot.reference);
    }
    await batch.commit();
    update();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomUsers(String token) {
    return  firestore.
       collection('rooms')
        .doc(token)
        .collection('chatUsers')
        .snapshots();

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(Room room) {
    return firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
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
