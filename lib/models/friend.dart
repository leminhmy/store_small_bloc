import 'package:cloud_firestore/cloud_firestore.dart';


class Friend {
  String? uid;
  String? name;
  int? statusFriend;
  String? image;
  String? tokenMessages;
  String? createdAt;
  String? updatedAt;

  Friend({
     this.uid,
    this.name,
    this.statusFriend,
    this.image,
    this.tokenMessages,
    this.createdAt,
    this.updatedAt,
  });

  static final empty =  Friend();
  bool get isEmpty => this == Friend.empty;
  bool get isNotEmpty => this != Friend.empty;

  factory Friend.fromJson(Map<String, dynamic> json){
    return Friend(
      uid: json['uid'],
      name: json['name'],
      statusFriend: json['statusFriend'],
      image: json['image'],
      tokenMessages: json['token_messages'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  factory Friend.formSnapshot(DocumentSnapshot snap){
    Friend friend = Friend(
      uid: snap.id,
      name: snap['name']??"",
      statusFriend: snap.data().toString().contains("statusFriend")?snap['statusFriend']:null,
      image: snap['image']??"",
      tokenMessages: snap['token_messages']??"",
      createdAt: snap['createdAt']??"",
      updatedAt: snap['updatedAt']??"",
    );
    return friend;
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "statusFriend": statusFriend,
      "image": image,
      "token_messages": tokenMessages,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}


