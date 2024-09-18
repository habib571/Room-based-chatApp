class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
    required this.readTime ,
    required this.senderName
  });

  late final String toId;
  late final String msg;
  late final bool read;
  late final String fromId;
  late final String readTime ;
  late final String sent;
  late final String senderName  ;
  late final Type type;

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString() ;
    msg = json['msg'].toString();
    read = json['read'];
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
    readTime = json['readTime'].toString() ;
    senderName =json['senderName'] ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['readTime'] = readTime ;
    data['senderName']  = senderName;
    return data;
  }
}

enum Type { text, image }