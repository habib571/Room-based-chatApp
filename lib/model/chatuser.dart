class ChatUser {
  ChatUser({
    required this.image,
    required this.name,  
    required this.email,   
    required this.id 
  });
  late String image;
  late String name;
  late String id ;  
  late String email ;
  
  ChatUser.fromJson(Map<String, dynamic> json) {
    //image = json['image'] ?? '';
    name = json['name'] ?? '';
    email =json['email']??'' ; 
    id =json['id']?? '' ;  
    image = json['image'] ??'';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
   
    data['image'] = image;
    data['name'] = name;
    data['email'] = email ; 
    data['id'] =id ; 
    
    return data;
  }
} 