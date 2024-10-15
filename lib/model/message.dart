import 'package:revi/model/event.dart';

class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
    required this.readTime,
    required this.senderName,
  });

  late final String toId;
  late final String msg;
  late final bool read;
  late final String fromId;
  late final String readTime;
  late final String sent;
  late final String senderName;
  late final Type type;

  Message.fromJson(Map<String, dynamic> json) {
    type = Type.values.firstWhere((e) => e.name == json['type']);

    switch (type) {
      case Type.event:
        toId = json['toId'];
        msg = json['msg'];
        read = json['read'];
        fromId = json['fromId'];
        sent = json['sent'];
        readTime = json['readTime'];
        senderName = json['senderName'];
        break;
      case Type.image:
      case Type.text:
        toId = json['toId'];
        msg = json['msg'];
        read = json['read'];
        fromId = json['fromId'];
        sent = json['sent'];
        readTime = json['readTime'];
        senderName = json['senderName'];
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['readTime'] = readTime;
    data['senderName'] = senderName;
    return data;
  }
}

enum Type { text, image, event }
