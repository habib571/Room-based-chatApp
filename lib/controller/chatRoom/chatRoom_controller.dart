import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/model/Room.dart';
import 'package:revi/model/chatuser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/message.dart';

class ChatRoomcontroller extends GetxController {
  TextEditingController inp = TextEditingController();
  @override
  void dispose() {
    inp.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get user => AuthController.currentUser();
  getCurrentUser() async {
    log('hfzolsehfnozresfhzo ${user!.uid}');
    final docSnapshot =
        await firestore.collection('users').doc(user!.uid).get();
    chatUser = ChatUser.fromJson(docSnapshot.data()!);
  }

  ChatUser? chatUser;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(Room room) {
    return firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  updateLastMessage(Room room, String message) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final messagequery = await firestore
        .collection('users')
        .doc(user!.uid)
        .collection('myrooms')
        .where('token', isEqualTo: room.token)
        .get();
    final batch = FirebaseFirestore.instance.batch();
    for (final docSnapshot in messagequery.docs) {
      batch.update(
          docSnapshot.reference, {'lastMsgTime': time, 'lastMessage': message});
    }
    await batch.commit();
    update();
  }

  sendMessage(Room room, String msg, Type type) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //message to send
    final Message message = Message(
        toId: room.roomname,
        msg: msg,
        senderName: chatUser!.name,
        read: false,
        readTime: '',
        type: type,
        fromId: user!.uid,
        sent: time);

    firestore.collection('messages').add(message.toJson());
    //  updateLastMessage(room, message.msg);
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEventMessage(
      String token, String eventName) {
    return firestore
        .collection('rooms')
        .doc(token)
        .collection('events')
        .where("name", isEqualTo: eventName)
        .snapshots();
  }

  addParticipant(String token, String eventName) async {
    ChatUser chatUsr = await AuthController.getCurrentUser(user!.uid);
    firestore
        .collection('rooms')
        .doc(token)
        .collection('events')
        .doc(eventName)
        .collection('participant')
        .add(chatUsr.toJson());
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> isUserParticipated(String token, String eventName) {
    return  firestore
        .collection('rooms')
        .doc(token)
        .collection('events')
        .doc(eventName)
        .collection('participant')
        .where('id' , isEqualTo: user!.uid )
        .snapshots() ;


  }

  Stream<QuerySnapshot<Map<String, dynamic>>>  getParticipants(String token, String eventName) {
    return firestore
        .collection('rooms')
        .doc(token)
        .collection('events')
        .doc(eventName)
        .collection('participant')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getEventByName(String name, String token) {
    return firestore
        .collection('rooms')
        .doc(token)
        .collection('events')
        .doc(name)
        .snapshots() ;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String id) {
    return firestore.collection('users').doc(id).snapshots();
  }

  Future<void> updateMessageReadStatus(
      Message message, Room room, String userId) async {
    final messagesQuerySnapshot = await firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .where('fromId', isEqualTo: userId)
        .get();
    final batch = FirebaseFirestore.instance.batch();

    for (final docSnapshot in messagesQuerySnapshot.docs) {
      batch.update(docSnapshot.reference, {'read': true});
    }

    await batch.commit();
  }

  Future<void> sendChatImage(Room room, File file) async {
    final ext = file.path.split('.').last;

    final ref = FirebaseStorage.instance.ref().child(
        'images/${room.roomname}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    final imageUrl = await ref.getDownloadURL();
    await sendMessage(room, imageUrl, Type.image);
  }
}
