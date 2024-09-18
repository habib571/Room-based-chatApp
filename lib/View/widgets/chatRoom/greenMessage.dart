import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/helper/Date.dart';

import 'package:revi/model/message.dart';

class GreenMessage extends StatefulWidget {
  const GreenMessage({super.key, required this.message});

  final Message message;

  @override
  State<GreenMessage> createState() => _GreenMessageState();
}

class _GreenMessageState extends State<GreenMessage> {
  @override
  Widget build(BuildContext context) {
    //ChatRoomcontroller ctrl = Get.put(ChatRoomcontroller()) ;

    return BubbleNormal(
      isSender: true,
      delivered: false,
      sent: true,
      seen: widget.message.read,
      text:  widget.message.msg,
      color :Color(0xff2C5ACA) ,
      tail:false,
      textStyle: poppinsRegular.copyWith(color: Colors.white ,fontSize: 12) ,
      leading: Text(
        MyDate.getFormattedTime(context: context, time: widget.message.sent),
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );
  }
}
