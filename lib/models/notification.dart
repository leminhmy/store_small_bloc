class NotificationModel{
  String? id;
  String? name;
  String? title;
  String? body;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
     this.id,
     this.name,
     this.title,
     this.body,
     this.image,
     this.status,
     this.createdAt,
     this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "image": image,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}