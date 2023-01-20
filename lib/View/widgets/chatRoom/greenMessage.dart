import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/model/Date.dart'; 
import 'package:revi/controller/chatRoom/chatRoom_controller.dart'; 
 import 'package:revi/model/message.dart' ; 
  class GreenMessage extends StatefulWidget {
   GreenMessage({super.key }); 
late  Message _message ;

  @override
  State<GreenMessage> createState() => _GreenMessageState();
} 

class _GreenMessageState extends State<GreenMessage> { 
late  Message _message ;

 
  @override 
  
  Widget build(BuildContext context) {  
    ChatRoomcontroller ctrl = Get.put(ChatRoomcontroller()) ;
   
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
         const    SizedBox(width: 100),

            //double tick blue icon for message read
            if (widget._message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDate.getFormattedTime(
                  context: context, time: widget._message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget._message.type == Type.image
                ? 40
                : 40),
            margin: const   EdgeInsets.symmetric(
                horizontal: 30, vertical: 40),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget._message.type == Type.text
                ?
                //show text
                Text(
                    widget._message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget._message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}