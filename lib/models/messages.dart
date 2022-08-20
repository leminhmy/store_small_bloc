class MessagesModel{
  int? id;
  int? idSend;
  int? idTake;
  String? messaging;
  String? image;
  int? see;
  String? createdAt;
  String? updatedAt;

  MessagesModel({
    this.id,
    this.idSend,
    this.idTake,
    this.messaging,
    this.image,
    this.see,
    this.createdAt,
    this.updatedAt
  });

  MessagesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idSend = json['id_send'];
    idTake = json['id_take'];
    messaging = json['messaging'];
    image = json['image'];
    see = json['see'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "id_send": this.idSend,
      "id_take": this.idTake,
      "messaging": this.messaging,
      "image": this.image,
      "see": this.see,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}

List<MessagesModel> demo_messages = [
  MessagesModel(id: 1,idSend: 1,idTake: 2,messaging: "Hello1",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: 2,idSend: 2,idTake: 1,messaging: "Hello2",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: 3,idSend: 2,idTake: 1,messaging: "Hello3",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: 4,idSend: 1,idTake: 2,messaging: "Hello4",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
];