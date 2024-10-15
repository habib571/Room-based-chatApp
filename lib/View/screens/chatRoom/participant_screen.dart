import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/View/widgets/chatRoom/participant_widget.dart';
import 'package:revi/model/event.dart';

import '../../../controller/chatRoom/chatRoom_controller.dart';
import '../../../model/Room.dart';
import '../../../model/chatuser.dart';
import '../../styles/colors.dart';

class ParticipantScreen extends StatelessWidget {
   ParticipantScreen({super.key, required this.room, required this.event}) ;
  final ChatRoomcontroller _ctrl = Get.put(ChatRoomcontroller())  ;
  final Room room ;
  final Event event ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar :   AppBar(
          title: Text(
            'Group Details',
            style: poppinsSemiBold.copyWith(
                color: AppColors.primaryColor, fontSize: 20),
          ),
          leading: IconButton(
              onPressed: (() {
                Get.back();
              }),
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.primaryColor)),
        ),
       body: Padding(
           padding: const EdgeInsets.only(left: 25 , right: 25 , top: 40 , bottom: 30) ,
           child:  StreamBuilder(
             stream: _ctrl.getParticipants(room.token, event.name) ,
             builder: ((context, snapshot) {
               switch (snapshot.connectionState) {
                 case ConnectionState.waiting:
                 case ConnectionState.none:
                   return const Center(
                       child: CircularProgressIndicator(
                         color: AppColors.primaryColor,
                       ));
                 case ConnectionState.active:
                 case ConnectionState.done:
                   final data = snapshot.data?.docs;
                  final list =
                       data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                           [];

                   if (list.isNotEmpty) {
                     return ListView.separated(
                         separatorBuilder: (context, index) => const Divider(
                           color: Color(0xffCDD4D9),
                           thickness: 0.5,
                         ),
                         shrinkWrap: true,
                         physics: const BouncingScrollPhysics(),
                         itemCount: list.length,
                         itemBuilder: (BuildContext ctx, index) {
                           return ParticipantWidget(user: list[index], isCreator: list[index].id != event.creatorId ? false : true) ;
                         });
                   }

                   return const Center(
                     child: Text('No Participant !',
                         style: TextStyle(fontSize: 25)),
                   );
               }
             }),
           )
       )
    ) ;
  }
}
