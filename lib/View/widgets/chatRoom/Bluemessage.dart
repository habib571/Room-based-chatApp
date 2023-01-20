
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/model/Date.dart';
import 'package:revi/model/message.dart';
class BlueMessage extends StatefulWidget {
   BlueMessage({super.key }); 
  
late Message _message ;
  @override
  State<BlueMessage> createState() => _BlueMessageState();
}

class _BlueMessageState extends State<BlueMessage> {   
  
  ChatRoomcontroller ctr = Get.put(ChatRoomcontroller()) ;
  @override
  Widget build(BuildContext context) { 
    if(widget._message.read.isNotEmpty) {
 ChatRoomcontroller.updateMessageReadStatus(widget._message) ;
    }
  return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget._message.type == Type.image
                ? 100
                : 100),
            margin: const EdgeInsets.symmetric(
                horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
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

        //message time
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            MyDate.getFormattedTime(
                context: context, time: widget._message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}