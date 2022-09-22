

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';

class ChatRepository{
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ChatRepository(
      {FirebaseFirestore? firebaseFirestore, FirebaseStorage? firebaseStorage})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
      _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;


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

  Future<String> updateStatusMessage({required List<MessagesModel> listMessage,required String uid,required String idFriend}) async{
    listMessage.removeWhere((element) => element.see == 1 || element.idSend == uid);
    if(listMessage.isNotEmpty){
      WriteBatch batch = _firebaseFirestore.batch();
      List<DocumentReference> db1 =  List.generate(listMessage.length, (index) => _firebaseFirestore.
      collection("users/$uid/friends/$idFriend/messaging").doc(listMessage[index].id));
      for(int i =0; i< listMessage.length; i ++){
        batch.update(db1[i], {"see": 1});
      }
      try{
        await batch.commit();
        print("updateStatusMessage success");
        return "";
      }on FirebaseException catch(error){
        print("updateStatusMessage error ${error.message}");
        return "Error: ${error.message}";
      }
    }else{
      return "";
    }

  }

  Future<String> addFriend({required List<Friend> newListFriend, required Friend your}) async{
    your.statusFriend = 2;
    WriteBatch batch = _firebaseFirestore.batch();
    List<DocumentReference> listDb1 =
    List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${your.uid}/friends").doc(newListFriend[index].uid));
    List<DocumentReference> listDb2 =
    List.from(List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${newListFriend[index].uid}/friends").doc(your.uid)));
    for(int i = 0; i < newListFriend.length; i++){
      newListFriend[i].statusFriend = 0;
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
  Future<String> acceptFriend({required List<Friend> newListFriend, required Friend your}) async{
    your.statusFriend = 1;
    WriteBatch batch = _firebaseFirestore.batch();
    List<DocumentReference> listDb1 =
    List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${your.uid}/friends").doc(newListFriend[index].uid));
    List<DocumentReference> listDb2 =
    List.from(List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${newListFriend[index].uid}/friends").doc(your.uid)));
    for(int i = 0; i < newListFriend.length; i++){
      newListFriend[i].statusFriend = 1;
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
  Future<String> unFriend({required List<Friend> newListFriend, required Friend your}) async{
    WriteBatch batch = _firebaseFirestore.batch();
    List<DocumentReference> listDb1 =
    List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${your.uid}/friends").doc(newListFriend[index].uid));
    List<DocumentReference> listDb2 =
    List.from(List.generate(newListFriend.length, (index) => _firebaseFirestore.collection("users/${newListFriend[index].uid}/friends").doc(your.uid)));
    for(int i = 0; i < newListFriend.length; i++){
      batch.delete(listDb1[i]);
      batch.delete(listDb2[i]);
    }
    try{

      await batch.commit();
      print("unFriend success");
      return "";
    } on FirebaseException catch(error){
      print("addOrder error ${error.message}");
      return "Error: ${error.message}";
    }
  }



  Stream<List<Friend>> getAllFriend(String uidUser){
    return _firebaseFirestore.collection("users/$uidUser/friends").where("statusFriend",isEqualTo: 1).snapshots().map((event) {
      print("db change getAllFriend ${event.docs.length}");
      return event.docs.map((e) => Friend.fromJson(e.data())).toList();
    });
  }

  Stream<List<Friend>> getAllInviteFriend(String uidUser){
    return _firebaseFirestore.collection("users/$uidUser/friends").where("statusFriend",isNotEqualTo: 1).snapshots().map((event) {
      print("db change getAllFriend ${event.docs.length}");
      return event.docs.map((e) => Friend.fromJson(e.data())).toList();
    });
  }

   updateInfoFriend({required String uidFriend, required int statusFriend}){
    _firebaseFirestore.collection("users").doc(uidFriend).get().then((value) {
      Friend friend = Friend.fromJson(value.data()!);
      friend.statusFriend = statusFriend;
      friend.updatedAt = DateTime.now().toString();
      _firebaseFirestore.collection("users/${AuthRepository.currentUser.id}/friends")
          .doc(uidFriend).update(friend.toJson());
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
        .where("see",isEqualTo: 0).where("idTake",isEqualTo: uidUser).snapshots().map((event){
      return event.docs.length;
    });
  }

  Stream<List<Friend>> streamAllPeople(){
    return _firebaseFirestore.collection("users")
        .snapshots().map((event){
      return event.docs.map((e) => Friend.fromJson(e.data())).toList();
    });
  }


  Future<String> uploadFile({required XFile image, required String uidFriend, required String uid}) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("img_users")
        .child(uid)
        .child("chats")
        .child(uidFriend);
    UploadTask uploadTask = reference.putFile(File(image.path));
    try {
      String getUrlImg = "";
      await uploadTask.whenComplete(() async {
        getUrlImg = await reference.getDownloadURL();
      });

      return getUrlImg;
    } on FirebaseException catch (error) {
      print("error loaded: ${error.message}");
      return "error: ${error.message}";
    }
  }



}