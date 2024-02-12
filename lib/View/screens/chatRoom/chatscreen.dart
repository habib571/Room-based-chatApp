import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/widgets/chatRoom/Appbar_chat.dart';
import 'package:revi/View/widgets/chatRoom/ChatInput.dart';
import 'package:revi/View/widgets/chatRoom/messageCard.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import '../../../model/Room.dart';
import '../../../model/message.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.room});

  final Room room;
  List<Message> _list = [];

  final bool _showEmoji = false;
  final bool _isUploading = false;

  ChatRoomcontroller ctrl = Get.put(ChatRoomcontroller());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 248, 255),
        appBar: AppBar(
            backgroundColor: themecolor,
            automaticallyImplyLeading: false,
            flexibleSpace: ChatAppBar(room: room)),
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<ChatRoomcontroller>( 
                init: ChatRoomcontroller(),
                builder: (ctrl) {
                  return StreamBuilder(
                    stream: ctrl.getAllMessages(room),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();
                      
                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];
                      
                         
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(
                                    message: _list[index],
                                    room: room,
                                  );
                                });
                       
                          
                      }
                    },
                  );
                }
              ),
            ),
    
            //progress indicator for showing uploading
            if (_isUploading)
              const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: CircularProgressIndicator(strokeWidth: 2))),
    
            //chat input filed
            ChatInput(
              room: room,
            ),
    
            //show emojis on keyboard emoji button click & vice versa
            if (_showEmoji)
              SizedBox(
                height: mq.height * .35,
                child: EmojiPicker(
                  textEditingController: ctrl.inp,
                  config: Config(
                    bgColor: const Color.fromARGB(255, 234, 248, 255),
                    columns: 8,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
