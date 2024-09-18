import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/chatRoom/room_ino_screen.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/controller/Roomscontroller/roompage_controller.dart';
import 'package:revi/model/Room.dart';
import 'package:revi/model/chatuser.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key, required this.room});
  final Room room;

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  RoomPageController ctrl = Get.put(RoomPageControllerImp());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: StreamBuilder(
          stream: ctrl.getRoomInfo(widget.room),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Room.fromJson(e.data())).toList() ?? [];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Color(0xffBFC4D3))),
                      widget.room.image != ''
                          ? CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:
                                  // ignore: unnecessary_null_comparison
                                  NetworkImage(widget.room.image),
                              // foregroundColor: Colors.red,
                            )
                          : CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey.shade300,
                              // foregroundColor: Colors.red,
                              child: Center(
                                  child: Text(
                                widget.room.roomname[0].toUpperCase(),
                                style: const TextStyle(fontSize: 25),
                              ))),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              list.isNotEmpty
                                  ? list[0].roomname
                                  : widget.room.roomname,
                              style: poppinsBold.copyWith(fontSize: 20)),
                          StreamBuilder(
                            stream: ctrl.getRoomUsers(widget.room.token),
                            builder: (context, snapshot) {
                              final data = snapshot.data?.docs;
                              if (snapshot.hasData) {

                                final userList = data!
                                    .map((e) => ChatUser.fromJson(e.data()))
                                    .toList() ?? [];

                                List<Text> names = [];
                                for (int i = 0; i < userList.length; i++) {
                                  names.add(Text(
                                    '${userList[i].name} ,',
                                    style: poppinsRegular.copyWith(
                                        color: AppColors.secondaryTxtColor, fontSize: 14),
                                  ));
                                }
                                return Row(children: names);
                              }
                              return const Text('You');
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call),
                        color: AppColors.primaryColor),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.video_camera_front),
                        color: AppColors.primaryColor),
                    IconButton(
                        onPressed: () {
                          Get.to(() => RoomDetailsScreen(room: widget.room,) );
                        },
                        icon: const Icon(Icons.info_sharp),
                        color: AppColors.primaryColor),
                  ],
                )
              ],
            );
          }),
    );
  }
}
