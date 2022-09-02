import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel{
  String? id;
  String? messaging;
  String? idSend;
  String? idTake;
  String? image;
  int? see;
  String? createdAt;
  String? updatedAt;

  MessagesModel({
    this.id,
    this.messaging,
    this.image,
    this.idTake,
    this.idSend,
    this.see,
    this.createdAt,
    this.updatedAt
  });

  factory MessagesModel.formSnapshot(DocumentSnapshot snap){
    MessagesModel messages = MessagesModel(
      id:snap['id'],
      messaging:snap['messaging'],
      image:snap['image'],
      idSend:snap['idSend'],
      idTake:snap['idTake'],
      see:snap['see'],
      createdAt:snap['createdAt'],
      updatedAt:snap['updatedAt'],
    );
    return messages;
  }

  factory MessagesModel.fromMap(Map<String, dynamic> json){
    MessagesModel messages = MessagesModel(
        id:json['id'],
        messaging:json['messaging'],
        image:json['image'],
        idSend:json['idSend'],
        idTake:json['idTake'],
        see:json['see'],
        createdAt:json['createdAt'],
        updatedAt:json['updatedAt'],
    );
    return messages;
  }



  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "messaging": messaging,
      "image": image,
      "idSend": idSend,
      "idTake": idTake,
      "see": see,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

/*
List<MessagesModel> demo_messages = [
  MessagesModel(id: "1",messaging: "Hello1",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: "2",messaging: "Hello2",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: "3",messaging: "Hello3",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
  MessagesModel(id: "4",messaging: "Hello4",image: "",see: 0,createdAt: "2022-08-11 10:20:10",updatedAt: "2022-08-11 10:20:10"),
];*/
