
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/model/message.dart'; 
import '../../../model/Room.dart';
import 'Bluemessage.dart'; 
import 'greenMessage.dart' ;
  class MessageCard extends StatefulWidget {
  const MessageCard({
  super.key, 
  required this.message ,
  required this.room
  }); 
  final Message  message ; 
  final Room  room;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {  
  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller()) ;
  @override
  Widget build(BuildContext context) { 
    
    return ctr.user!.uid == widget.message.fromId ? 
     GreenMessage(message :widget.message ,) :BlueMessage(romm: widget.room, message :widget.message) ;
  } }