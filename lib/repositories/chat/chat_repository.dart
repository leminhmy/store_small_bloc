

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';

class ChatRepository{
  final FirebaseFirestore _firebaseFirestore;

  ChatRepository(
      {FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  Future<String> sendMessage(MessagesModel messages) async{
    try{
      await _firebaseFirestore.collection("users/${messages.idSend}/friends")
          .doc(messages.idTake).collection("messaging").add(messages.toJson());

      await _firebaseFirestore.collection("users/${messages.idTake}/friends")
          .doc(messages.idSend).collection("messaging").add(messages.toJson());

      print("Send message success");
      return "";
    } on FirebaseException catch(error){
      print("addOrder error ${error.message}");
      return "Error: ${error.message}";
    }
  }

  void sendMessToDb(){

  }

  Future<String> addFriend({required List<Friend> newListFriend, required Friend your}) async{
    WriteBatch batch = _firebaseFirestore.batch();
    List<DocumentReference> listDb1 =
    List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${your.uid}/friends").doc(newListFriend[index].uid));
    List<DocumentReference> listDb2 =
    List.from(List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${newListFriend[index].uid}/friends").doc(your.uid)));
    for(int i = 0; i < newListFriend.length; i++){
      batch.set(listDb1[i], newListFriend[i].toJson());
      batch.set(listDb2[i], your.toJson());
    }
    try{

      await batch.commit();
      print("AddFriend success");
      return "";
    } on FirebaseException catch(error){
      print("addOrder error ${error.message}");
      return "Error: ${error.message}";
    }
  }



  Stream<List<Friend>> getAllFriend(String uidUser){
    return _firebaseFirestore.collection("users/$uidUser/friends").snapshots().map((event) {
      print("db change getAllFriend ${event.docs.length}");
      return event.docs.map((e) => Friend.formSnapshot(e)).toList();
    });
  }
  
  Stream<List<MessagesModel>> streamMessageFriend({required String uidUser, required String uidFriend}){
    return _firebaseFirestore.collection("users/$uidUser/friends").doc(uidFriend).collection("messaging")
        .orderBy("createdAt",descending: true).snapshots().map((event){
       return event.docs.map((e) => MessagesModel.formSnapshot(e)).toList();
    });
  }

  Stream<MessagesModel> streamLastMessageFriend({required String uidUser, required String uidFriend}){
    return _firebaseFirestore.collection("users/$uidUser/friends").doc(uidFriend).collection("messaging")
        .orderBy("createdAt",descending: true).snapshots().map((event){
      return MessagesModel.fromMap(event.docs[0].data());
    });
  }

  Stream<int> streamLengthMissMessageFriend({required String uidUser, required String uidFriend}){
    return _firebaseFirestore.collection("users/$uidUser/friends").doc(uidFriend).collection("messaging")
        .where("see",isEqualTo: 0).snapshots().map((event){
      return event.docs.length;
    });
  }

  Stream<List<Friend>> streamAllPeople(){
    return _firebaseFirestore.collection("users")
        .snapshots().map((event){
      return event.docs.map((e) => Friend.formSnapshot(e)).toList();
    });
  }




}