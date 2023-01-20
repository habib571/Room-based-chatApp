import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/model/Date.dart';
import 'package:revi/model/message.dart'; 
import 'Bluemessage.dart'; 
import 'greenMessage.dart' ;
  class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message}); 
  final Message  message ; 

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {  
  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller()) ;
  @override
  Widget build(BuildContext context) { 
    
    return ChatRoomcontroller.user!.uid == widget.message.fromId ?  GreenMessage() :BlueMessage() ;
  } }