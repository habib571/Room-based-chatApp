import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/helper/Date.dart';
import 'package:revi/model/chatuser.dart';
import 'package:revi/model/event.dart';
import 'package:revi/model/message.dart';

import '../../../model/Room.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import 'event_widget.dart';

class BlueMessage extends StatefulWidget {
  BlueMessage(
      {super.key,
      required this.room,
      required this.message,
      required this.userId});
  Room room;
  final Message message;
  final String userId;


  @override
  State<BlueMessage> createState() => _BlueMessageState();
}

class _BlueMessageState extends State<BlueMessage> {
  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller());
  @override
  void initState() {
    ctr.getUserInfo(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctr.updateMessageReadStatus(widget.message, widget.room, widget.userId);

    return
      widget.message.type == Type.event ?
      StreamBuilder(
          stream: ctr.getEventMessage(widget.room.token, widget.message.msg),
          builder: (context ,snapshot) {
            if(snapshot.hasData) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Event.fromJson(e.data())).toList() ?? [];
              final event = list.firstWhere((element) => element.name == widget.message.msg) ;
              return  EventCard(event: event, isUpdate: false ,room: widget.room, ) ;

            }
            return  const SizedBox.shrink() ;
          }
      ) :

      Row(
      children: [
        const SizedBox(width: 16,) ,
        StreamBuilder(
            stream: ctr.getUserInfo(widget.userId),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                final user = ChatUser.fromJson(data!.data()!);

                return user.image != ''
                    ? CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.accentColor,
                        backgroundImage:
                            // ignore: unnecessary_null_comparison
                            NetworkImage(user.image),
                        // foregroundColor: Colors.red,
                      )
                    : const CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.accentColor,
                        // foregroundColor: Colors.red,
                        child: Center(child: Icon(CupertinoIcons.person)));
              }

              return const CircleAvatar(
                  radius: 8,
                  backgroundColor: AppColors.accentColor,
                  // foregroundColor: Colors.red,
                  child: Center(child: Icon(CupertinoIcons.person)));
            }),
        SizedBox(height: 15) ,
        widget.message.type == Type.image ?
            BubbleNormalImage(

                id: widget.message.readTime,
                image: Image(image: NetworkImage(widget.message.msg))
            ) :


        BubbleNormal(
          isSender: false,
          text: widget.message.msg,
          color: const Color(0xffEAECF2),
          textStyle: poppinsRegular.copyWith(
              color: const Color(0xff63697B), fontSize: 12),
        ),
      ],
    );
  }
}
