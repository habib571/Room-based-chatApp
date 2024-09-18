import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/chatRoom/chatscreen.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/controller/Roomscontroller/roompage_controller.dart';
import 'package:revi/helper/Date.dart';
import 'package:revi/model/Room.dart';
import '../../../model/message.dart';
class ConversationCard extends StatelessWidget {
  ConversationCard({
    super.key,
    required this.room,
  });
  final Room room;

  late int countMessages;
  Message? _message;
  final RoomPageControllerImp _controller = Get.put(RoomPageControllerImp());

  @override
  Widget build(BuildContext context) {
    final List<Align> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        const Align(
          widthFactor: 0.6,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
            ),
            radius: 10,
          ),
        ),
      );
    }
    RoomPageControllerImp ctr = Get.put(RoomPageControllerImp());
    return InkWell(
        onTap: () {
          Get.to(ChatScreen(room: room));
        },
        child: StreamBuilder(
            stream: _controller.getLastMessage(room),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(children: [
                    room.image != ''
                        ? CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.accentColor,
                            backgroundImage:
                                // ignore: unnecessary_null_comparison
                                NetworkImage(room.image),
                            // foregroundColor: Colors.red,
                          )
                        : CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.accentColor,
                            // foregroundColor: Colors.red,
                            child: Center(
                                child: Text(
                              room.roomname[0].toUpperCase(),
                              style: const TextStyle(fontSize: 25),
                            ))),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(room.roomname,
                                    style: poppinsBold.copyWith(fontSize: 17)),
                                const SizedBox(
                                  height: 10,
                                ),
                                _message != null
                                    ? SizedBox(
                                        width: 150,
                                        child: Text(
                                          _message!.senderName !=
                                                  _controller.user.displayName
                                              ? '${_message!.senderName} : ${_message!.msg}'
                                              : 'You: ${_message!.msg}',
                                          style: _message!.read
                                              ? poppinsMedium.copyWith(
                                                  fontSize: 11,
                                                  color: AppColors
                                                      .secondaryTxtColor)
                                              : poppinsSemiBold.copyWith(
                                                  fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _message != null
                                ? Text(
                                    MyDate.getFormattedTime(
                                        context: context,
                                        time: _message!.sent),
                                    style: poppinsSemiBold.copyWith(
                                        fontSize: 10,
                                        color: AppColors.secondaryTxtColor))
                                : const SizedBox.shrink()
                          ]),

                    ),
                  ]),
                ),
              );
            }));

    /*Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: InkWell(
          onTap: () {
            Get.to(ChatScreen(room: room));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      room.isUserAdmin
                          ? const Image(
                              image: AssetImage('assets/admin.png'),
                              height: 25,
                              width: 25,
                            )
                          : const SizedBox(),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert), // Three-dot icon
                        onSelected: (String result) {},
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                              value: 'delete',
                              child: const Text('delete room'),
                              onTap: () async {
                                ctr.deleteRoom(room);
                              }),
                          const PopupMenuItem<String>(
                            value: 'about',
                            child: Text('About'),
                          ),
                        ],
                      )
                    ],
                  ),

                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    // ignore: unnecessary_null_comparison
                    backgroundImage:
                        // ignore: unnecessary_null_comparison
                        room.image != null ? NetworkImage(room.image) : null,
                    // foregroundColor: Colors.red,
                    child: Center(
                        child: Text(
                      room.image == '' ? room.roomname[0].toUpperCase() : '',
                      style: const TextStyle(fontSize: 25),
                    )),
                  ),
                  const SizedBox(height: 10),
                  // const  SizedBox(height: 3,) ,
                  Text(
                    room.roomname,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: list),
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
            ),
          )),
    );*/
  }
}
