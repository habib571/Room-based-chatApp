import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:revi/View/widgets/chatRoom/Appbar_chat.dart' ; 
import 'package:revi/View/widgets/chatRoom/ChatInput.dart'; 
import 'package:revi/View/widgets/chatRoom/greenMessage.dart';
import 'package:revi/View/widgets/chatRoom/Bluemessage.dart'; 
/*import 'package:revi/View/widgets/chatRoom/messageCard.dart';
import 'package:revi/controller/chatRoom/chatRoom_controller.dart';
import 'package:revi/model/chat-user.dart';
import 'package:revi/main.dart';
import '../../../model/Room.dart';
import '../../../model/message.dart'; 
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key ,required this.room ,required this.user});
  
  final ChatUser user ; 
final Room room ;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> { 
    List<Message> _list = [];
  bool _showEmoji = false, _isUploading = false; 
  ChatRoomcontroller ctrl =Get.put(ChatRoomcontroller());
  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
  onTap: () =>  FocusScope.of(context).unfocus() ,
  child: SafeArea(
    child: WillPopScope(
      onWillPop:  (() {
        
      if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
  }}  
    
   ) ,
    child: Scaffold(
       backgroundColor: const Color.fromARGB(255, 234, 248, 255),
      appBar:  AppBar(automaticallyImplyLeading: false,
              flexibleSpace: ChatAppBar(room: widget.room)

    ),
    body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: ctrl.getAllMessages(widget.user),
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

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(message: _list[index]);
                                });
                          } else {
                            return const Center(
                              child: Text('Welcome! 👋',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
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
               ChatInput(user: widget.user);

                //show emojis on keyboard emoji button click & vice versa
                if (_showEmoji) 
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: ctrl.inp 
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
        ),
      ),
    );
    
    
  
  }
}
 */
