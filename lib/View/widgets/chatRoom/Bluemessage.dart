import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/helper/Date.dart';
import 'package:revi/model/chatuser.dart';
import 'package:revi/model/message.dart';

import '../../../model/Room.dart';
import '../../styles/styles.dart';

class BlueMessage extends StatefulWidget {
  BlueMessage(
      {super.key,
      required this.romm,
      required this.message,
      required this.userId});
  Room romm;
  final Message message;
  final String userId;

  @override
  State<BlueMessage> createState() => _BlueMessageState();
}

class _BlueMessageState extends State<BlueMessage> {
  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller());
  @override
  Widget build(BuildContext context) {
    ctr.updateMessageReadStatus(widget.message, widget.romm, widget.userId);

    return BubbleNormal(
      isSender: false,
      text: widget.message.msg,
      color: const Color(0xffEAECF2),
      textStyle:
          poppinsRegular.copyWith(color: const Color(0xff63697B), fontSize: 12),
    );
  }
}
