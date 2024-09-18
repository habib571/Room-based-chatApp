
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/model/chatuser.dart';
import 'package:revi/model/message.dart'; 
import '../../../model/Room.dart';
import 'Bluemessage.dart'; 
import 'greenMessage.dart' ;
  class MessageCard extends StatelessWidget {
MessageCard({
  super.key, 
  required this.message ,
  required this.room, required this.userId
  }); 
  final Message  message ; 
  final Room  room;
  final String userId ;

  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller()) ;

  @override
  Widget build(BuildContext context) {

    return ctr.user!.uid == message.fromId ?
     GreenMessage(message :message ,) :BlueMessage(romm: room, message :message, userId: userId,) ;
  } }