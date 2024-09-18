import 'dart:developer';
import 'dart:io';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revi/model/message.dart';

import '../../../model/Room.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, required this.room});

  final Room room;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  ChatRoomcontroller ctrl = Get.put(ChatRoomcontroller());
  bool _showEmoji = false, _isUploading = false;
  final inp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
 return
Row(
  children: [
    //input field & buttons
    Expanded(
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            //emoji button
            IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  setState(() => _showEmoji = !_showEmoji);
                },
                icon: const Icon(Icons.emoji_emotions,
                    color: Color(0xffBFC4D3), size: 25)),

            Expanded(
                child: TextField(
              controller: inp,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onTap: () {
                if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
              },
              decoration:  InputDecoration(
                  hintText: 'Type Something...',
                  hintStyle: poppinsRegular.copyWith(color: Color(0xff63697B) ,fontSize: 14),
                  border: InputBorder.none),
            )),

            //pick image from gallery button
            IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  // Picking multiple images
                  final List<XFile> images =
                      await picker.pickMultiImage(imageQuality: 70);

                  // uploading & sending image one by one
                  for (var i in images) {
                    log('Image Path: ${i.path}');
                    setState(() => _isUploading = true);
                    await ctrl.sendChatImage(widget.room, File(i.path));
                    setState(() => _isUploading = false);
                  }
                },
                icon:
                    const Icon(Icons.image, color :Color(0xffBFC4D3), size: 26)),

            //take image from camera button
            IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  // Pick an image
                  final XFile? image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 70);
                  if (image != null) {
                    log('Image Path: ${image.path}');
                    setState(() => _isUploading = true);

                    await ctrl.sendChatImage(
                        widget.room, File(image.path));
                    setState(() => _isUploading = false);
                  }
                },
                icon: const Icon(Icons.camera_alt_rounded,
                    color: Color(0xffBFC4D3), size: 26)),

            //adding some space
            SizedBox(width: mq.width * .02),
          ],
        ),
      ),
    ),

    //send message button
 IconButton(
        onPressed: () {
          if (inp.text.isNotEmpty) {
            ctrl.sendMessage(widget.room, inp.text, Type.text);
            inp.text = '';
          }
        },
          icon: const Icon(
              Icons.send_rounded, color: AppColors.primaryColor, size: 28),
      )

  ],
);
  }
}
