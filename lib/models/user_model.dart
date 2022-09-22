import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String? name;
  String? email;
  String? address;
  int? phone;
  int? status;
  String? image;
  String? tokenMessages;

  UserModel({
     required this.id,
     this.name,
     this.email,
     this.phone,
     this.status,
    this.address,
     this.image,
     this.tokenMessages,
  });

  static final empty =  UserModel(id: '');
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['uid'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
         address: json['address'],
        status: json['status'],
        image: json['image'],
        tokenMessages: json['token_messages'],
    );
  }

  factory UserModel.formSnapshot(DocumentSnapshot snap){
    UserModel userModel = UserModel(
      id: snap.id,
      name: snap['name'],
      email: snap['email'],
      phone: snap['phone'],
      address: snap['address'],
      status: snap['status'],
      image: snap['image'],
      tokenMessages: snap['token_messages'],
    );
    return userModel;
  }



  factory UserModel.fromMap(map){
    return UserModel(
      id: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      status: map['status'],
      address: map['address'],
      image: map['image'],
      tokenMessages: map['token_messages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": id,
      "name": name,
      "email": email,
      "phone": phone,
      "status": status,
      "address": address,
      "image": image,
      "token_messages": tokenMessages,
    };
  }
}

List<UserModel> demo_listUser = [
  UserModel(id: "1", name: "name1", email: "email@gmail.com", phone: 123456879, status: 1, image: 'assets/images/person_icon.jpg', tokenMessages: ""),
  UserModel(id: "2", name: "name2", email: "email@gmail.com", phone: 123456879, status: 1, image: 'assets/images/person_icon.jpg', tokenMessages: ""),
  UserModel(id: "3", name: "name3", email: "email@gmail.com", phone: 123456879, status: 1, image: 'assets/images/person_icon.jpg', tokenMessages: ""),
  UserModel(id: "4", name: "name4", email: "email@gmail.com", phone: 123456879, status: 1, image: 'assets/images/person_icon.jpg', tokenMessages: ""),
];
