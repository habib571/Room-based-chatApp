


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/chatRoom/event_screen.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/View/screens/chatRoom/participant_screen.dart';
import 'package:revi/model/chatuser.dart';
import 'package:revi/model/event.dart';

import '../../../controller/chatRoom/chatRoom_controller.dart';
import '../../../model/Room.dart';

class EventCard extends StatefulWidget {
   const EventCard({super.key, required this.event, required this.isUpdate, required this.room});
 final Event event ;
  final bool isUpdate ;
  final Room room ;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final ChatRoomcontroller _chtCtr =Get.find() ;
  @override
  void initState() {
    _chtCtr.isUserParticipated(widget.room.token, widget.event.name) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50  , vertical: 20),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor)
            ),
            child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.calendar_month_sharp,
                  color: Colors.deepOrange,
                ),
                const SizedBox(width: 15,) ,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event',
                      style: poppinsBold.copyWith(
                          color: AppColors.primaryColor, fontSize: 17),
                    ),
                    const SizedBox(height: 10,) ,
                    Text(
                      widget.event.name,
                      style: poppinsSemiBold.copyWith(
                          color: AppColors.primaryColor, fontSize: 14),
                    ),
                    const SizedBox(height: 10,) ,
                    Row(
                      children: [
                        const Icon(Icons.calendar_month , color: AppColors.primaryColor) ,
                        Text(
                          widget.event.date,
                          style: poppinsRegular.copyWith(
                              color: AppColors.primaryColor, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,) ,
                    Row(
                      children: [
                        const Icon(Icons.access_time , color: AppColors.primaryColor,) ,
                        Text(
                          widget.event.time,
                          style: poppinsRegular.copyWith(
                              color: AppColors.primaryColor, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,) ,
                    Row(
                      children: [
                        const Icon(Icons.place_outlined , color : AppColors.primaryColor) ,
                        Text(
                          widget.event.location,
                          style: poppinsRegular.copyWith(
                              color: AppColors.primaryColor, fontSize: 14),
                        ),
                      ],
                    ) ,
                    const SizedBox(height: 50,)
                  ],
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
               right: 0,
              child:
              !widget.isUpdate ?
              StreamBuilder(
                stream:  _chtCtr.isUserParticipated(widget.room.token, widget.event.name)  ,
                builder: (context, snapshot) {

                  if(snapshot.hasData) {
                    final data = snapshot.data?.docs ;
                    final list = data!.map((e) => ChatUser.fromJson(e.data()) ).toList() ?? [] ;
                 return   list.isNotEmpty ?
                     Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green
                      ),
                      child: Center(
                        child: Text(
                          'Participated',
                          style: poppinsSemiBold.copyWith(
                              color: Colors.white, fontSize: 13),
                        ),
                      ),
                    )  :
                    InkWell(
                       onTap:(){
                        _chtCtr.addParticipant(widget.room.token, widget.event.name) ;
                       } ,
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor
                        ),
                        child: Center(
                          child: Text(
                          'Participate',
                            style: poppinsSemiBold.copyWith(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ),
                    ) ;
                  } else {
                    return const SizedBox() ;
                  }
                }
              ) :
              InkWell(
                onTap:(){
                  Get.to(()=>CreateEventScreen(room: widget.room , isEdit: true,event: widget.event, ))  ;
                } ,
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor
                  ),
                  child: Center(
                    child: Text(
                     'Edit Event' ,
                      style: poppinsSemiBold.copyWith(
                          color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
