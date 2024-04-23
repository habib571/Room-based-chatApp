import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revi/controller/auth/auth_controller.dart';
import 'package:revi/model/Room.dart';
import 'package:revi/model/chat-user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/message.dart';

class ChatRoomcontroller extends GetxController {
  TextEditingController inp = TextEditingController();
  @override
  void dispose() {
    inp.dispose();
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get user => AuthController.currentUser();

  /* String getConversationID(String id) => user!.uid.hashCode <= id.hashCode
      ? '${user!.uid}_$id'
      : '${id}_${user!.uid}';*/
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(Room room) {
    return firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .snapshots();
  }

  // for sending message
    sendMessage(Room room, String msg, Type type)  {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: room.roomname,
        msg: msg,
        read: '',
        type: type,
        fromId: user!.uid,
        sent: time);

    firestore.collection('messages').add(message.toJson());
    update();
  }

  //update read status of message
  Future<void> updateMessageReadStatus(Message message, Room room) async {
    final messagesQuerySnapshot = await firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .where('fromId', isEqualTo: user!.uid)
        .get();
    final batch = FirebaseFirestore.instance.batch();

    for (final docSnapshot in messagesQuerySnapshot.docs) {
      batch.update(docSnapshot.reference,
          {'read': DateTime.now().millisecondsSinceEpoch.toString()});
    }

    await batch.commit();
  }

  //get only last message of a specific chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser chatUser, Room room) {
    return firestore
        .collection('messages')
        .where('toId', isEqualTo: room.roomname)
        .where('fromId', isEqualTo: user!.uid)
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  Future<void> sendChatImage(Room room, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = FirebaseStorage.instance.ref().child(
        'images/${room.roomname}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(room, imageUrl, Type.image);
  }
}
