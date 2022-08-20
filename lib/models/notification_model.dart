class NotificationModel{
  int? id;
  String? userId;
  String? userIdSend;
  String? title;
  String? body;
  String? image;
  String? name;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.userIdSend,
    required this.title,
    required this.body,
    required this.image,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    userIdSend = json['user_idsend'];
    title = json['title'];
    body = json['body'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];


  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userId": this.userId,
      "user_idsend": this.userIdSend,
      "title": this.title,
      "body": this.body,
      "name": this.name,
      "image": this.image,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}