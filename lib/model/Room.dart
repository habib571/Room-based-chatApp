import 'package:revi/model/message.dart';

class Room {
  Room(
      {required this.token,
      required this.roomname,
      required this.image,
      this.isUserAdmin = false,
      this.unReadMessages = 0,
      this.lastMsgTime = '',
      this.lastMessage = ''});

  late final String token;
  late final String roomname;
  late final String image;
  late final String lastMsgTime;
  late final String lastMessage;
  late final int unReadMessages;

  bool isUserAdmin = false;
  Room.fromJson(Map<String, dynamic> json) {
    roomname = json['roomname'] ?? '';
    token = json['token'] ?? '';
    image = json['image'] ?? '';
    isUserAdmin = json['isUserAdmin'];
    lastMsgTime = json['lastMsgTime'];
    lastMessage = json['lastMessage'];
    unReadMessages = json['unReadMessages'] as int;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['roomname'] = roomname;
    data['token'] = token;
    data['image'] = image;
    data['isUserAdmin'] = isUserAdmin;
    data['lastMsgTime'] = lastMessage;
    data['lastMessage'] = lastMessage;
    data['unReadMessages'] = unReadMessages;

    return data;
  }
}
