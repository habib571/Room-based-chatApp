import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/chatRoom/chatscreen.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart';
import 'package:revi/model/Room.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.room,
  });
  final Room room;

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
    return Padding(
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
    );
  }
}
