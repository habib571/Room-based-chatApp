/*
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart';    
import 'package:revi/model/Room.dart' ;
import 'package:revi/routing/router_const.dart';









 class RoomCard extends StatefulWidget{
  const RoomCard( {super.key, 
  
  required this.room,  

  
  }
  );  
  final Room room ;  


  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) { 
    RoomPageControllerImp ctrl =Get.put(RoomPageControllerImp()) ;
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 15 ,horizontal: 50) ,
      child :   
      InkWell( 
        onTap: () {  

         /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user, room: widget.room,)));*/
                
        },
      child :
      Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction( 
              
              onPressed: ctrl.deleteRoom(),
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(30),
            )
          ],
        
        ),
        
      child:
      
       Container(
        height:  250,                                                       //____ ELEMENTS__________
        width:  250,
        decoration: BoxDecoration(
          color:const Color.fromARGB(223, 24, 109, 88), 
          borderRadius: BorderRadius.circular(30),
        ), 
        child: InkWell(  
          
            
          
          onTap: (() {
            Get.toNamed(Approuter.chatScreen) ;
          } ) , 

          child:  Column( 
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [   
           const  SizedBox(  
            height: 35,

            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children :[  
            const Text( 
               'Name:'  ,
               style: TextStyle( 
                fontSize: 20, 
                  fontWeight: FontWeight.bold 
               ),

            ) ,
           Text( 
             widget.room.roomname , 
             style: const  TextStyle( 
              fontSize: 20, 
              fontWeight: FontWeight.bold ),
          ) 
           ]
          ) ,
        const SizedBox( 
          height: 20,
        ), 

        Row(  
          mainAxisAlignment: MainAxisAlignment.center,
          children :[ 
            const Text( 
              'Token:' , 
              style: TextStyle( 
                fontSize: 16 , 
                fontWeight: FontWeight.bold
               
              ),

            ),
        SelectableText( 
             widget.room.token ,
             style: const  TextStyle( 
              fontSize: 16, 
               )
              ),
          ])
        
        
        ]
        )
        ),
      ),
     ) )); 
  }
}*/