import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/chatRoom/roominfo.dart';
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
          final data =snapshot.data?.docs ; 
          final list = data?.map((e) => Room.fromJson(e.data())).toList() ?? [] ; 
          return Row( 
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [ 
                     
                     IconButton(onPressed:   (() {
                        Get.back() ;
                           }) ,
                      icon: const Icon(Icons.arrow_back, color :Colors.white)
                      ), 
                      CircleAvatar( 
                       radius: 18,
                       backgroundColor: Colors.grey.shade300,  
                            // ignore: unnecessary_null_comparison
                        backgroundImage:widget.room.image != null ? NetworkImage(widget.room.image) : null ,  
                                 // foregroundColor: Colors.red,
                        child:Center(
                           child: Text( 
                           widget.room.image =='' ?widget.room.roomname[0].toUpperCase()  : '' ,
                            style:const TextStyle( 
                            fontSize: 25), )
                            ) ,
                            
                            ) , 
                           const SizedBox(width:10) , 
              
                          Text(  list.isNotEmpty? list[0].roomname:widget.room.roomname, 
                      style: const TextStyle( 
                      fontSize: 20, 
                      color:  Colors.white,
                      fontWeight: FontWeight.w400
                      ),
                          )
                  ],
                ),
              ),
              Row(
                children: [
                 IconButton(
                     onPressed:() {},
                     icon:const Icon(Icons.call) , 
                     color :Colors.white
                     ), 
                 IconButton(
                     onPressed:() {},
                     icon:const Icon(Icons.video_camera_front) , 
                     color :Colors.white
                     ), 
                 IconButton(
                      onPressed:() {
                        Get.to(()=>RoomInfo(room: widget.room) );
                      },
                      icon:const Icon(Icons.info_sharp) ,
                      color :Colors.white
                     ),
                ],
              )
            ],
          );
        })),
    );
  }
}
