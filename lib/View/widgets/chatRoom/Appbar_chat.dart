import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart' ;
import 'package:revi/model/Room.dart'; 

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key ,required this.room});
final Room room ;
 

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {  

  RoomPageController ctrl = Get.put(RoomPageControllerImp()) ;
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){}, 
      child: StreamBuilder(      
        stream: ctrl.getRoomInfo(widget.room),
        builder:((context, snapshot) {
          final data =snapshot.data!.docs ; 
          final list = data.map((e) => Room.fromJson(e.data())).toList() ; 
          return Row( 
            children: [ 
               IconButton(onPressed:   (() {
                  Get.back() ;
               }) ,
                icon: const Icon(Icons.arrow_back, color: Colors.green,)
                ), 
                Text(  list.isNotEmpty? list[0].roomname:widget.room.roomname, 
                style: const TextStyle( 
                  fontSize: 20, 
                  color:  Colors.black,
                  fontWeight: FontWeight.w400
                ),



                )
            ],
          );

        })
        
        
         ),
    );
  }
}
