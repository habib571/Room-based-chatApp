import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/View/widgets/chatRoom/event_widget.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/helper/Date.dart';
import 'package:revi/model/event.dart';

import 'package:revi/model/message.dart';

import '../../../controller/chatRoom/chatRoom_controller.dart';
import '../../../model/Room.dart';

class GreenMessage extends StatelessWidget {
  const GreenMessage({super.key, required this.message, required this.room});

  final Message message;
 final Room room ;


  @override
  Widget build(BuildContext context) {
    ChatRoomcontroller _ctrl = Get.put(ChatRoomcontroller())  ;

    return
    message.type == Type.event ?
       StreamBuilder(
           stream: _ctrl.getEventMessage(room.token, message.msg),
           builder: (context ,snapshot) {
             if(snapshot.hasData) {
               final data = snapshot.data?.docs;
               final list =
                   data?.map((e) => Event.fromJson(e.data())).toList() ?? [];
               final event = list.firstWhere((element) => element.name == message.msg) ;
               return  EventCard(event: event, isUpdate: true ,room: room, ) ;

             }
             return  const SizedBox.shrink() ;
           }
       ) :

      message.type == Type.image ?
      BubbleNormalImage(
        sent: true,
          id: message.readTime,
          image: Image(image: NetworkImage(message.msg))
      ) :
      BubbleNormal(
      isSender: true,
      delivered: false,
      sent: true,
      seen: message.read,
      text:  message.msg,
      color :const Color(0xff2C5ACA) ,
      tail:false,
      textStyle: poppinsRegular.copyWith(color: Colors.white ,fontSize: 12) ,
      leading: Text(
        MyDate.getFormattedTime(context: context, time: message.sent),
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );
  }
}
