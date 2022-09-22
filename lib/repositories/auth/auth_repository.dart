import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/notification_service/notification_repository.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFiretore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseMessaging _firebaseMessaging;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore, FirebaseStorage? firebaseStorage,FirebaseMessaging? firebaseMessaging })
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFiretore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
  _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  static UserModel currentUser = UserModel.empty;

  static List<UserModel> listAdmin  = [];
  static List<String> allTokenMessAdmin = [];



  Future<String> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    return token.toString();
  }

  sendNotification(List<String>? tokenMess, String title, String content,){
    if(tokenMess != null && tokenMess.isNotEmpty){
      NotificationRepository().
      sendNotification(listTokenMess: tokenMess,
          title: title, content: content,
          imgUrl: currentUser.image, name: currentUser.status == 2?"Admin":currentUser.name??"");
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamAccount(){
    return _firebaseFiretore.collection("users").doc(currentUser.id).snapshots();
  }

   _streamAccount({required String uid, required String tokenMess}){
     _firebaseFiretore.collection("users").doc(uid).snapshots().listen((event) {
      currentUser = UserModel.fromMap(event.data());
      if(tokenMess != currentUser.tokenMessages){
        updateAccount({"token_messages":tokenMess});
      }

    });
  }

    streamUser() {
     print("account call listen");

      _firebaseAuth.authStateChanges().listen((firebaseUser) async {
        print("account changed");
        if (firebaseUser != null) {
          String tokenMess = await getDeviceTokenToSendNotification();
          _streamAccount(uid:firebaseUser.uid,tokenMess: tokenMess);
        }
        else {
          currentUser = UserModel.empty;
          print("account logout ${currentUser.toJson()}");

        }
      });

  }





  Stream<List<UserModel>> getAllUser(){
    return _firebaseFiretore.collection("users").snapshots().map((event) {
      return event.docs.map((e) => UserModel.fromMap(e)).toList();
    });
  }

   void getAllAdmin(){
    print("start fn get all admin");
     _firebaseFiretore.collection("users").where("status",isEqualTo: 2).snapshots().listen((event) {
      listAdmin = event.docs.map((e) => UserModel.fromMap(e)).toList();
      allTokenMessAdmin = List.generate(listAdmin.length, (index) => listAdmin[index].tokenMessages!);

    });
  }


  Future<UserModel> getInfoUserFirebase(String uid) async {
    UserModel user = UserModel.empty;
    try {
      print(" start call getInfoUser");
      await _firebaseFiretore.collection("users").doc(uid).get().then((value) {
        user = UserModel.fromMap(value.data());
        print(user.toJson());
      });
      print("call success getInfoUser");
    } catch (e) {
      print("error $e");
    }
    return user;
  }




  Future<String> updateAccount(Map<String, dynamic> infoUpdate) async {
    try {
      print("uid: ${currentUser.id}");
      infoUpdate.removeWhere((key, value) => value == null);
      await _firebaseFiretore.collection("users")
          .doc(currentUser.id)
          .update(infoUpdate);
      return "Success";
    } on FirebaseException catch (error) {
      return "Error: ${error.message}";
    }
  }

  Future<String> uploadImageUser(XFile image) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("img_users")
        .child(currentUser.id)
        .child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    try {
      String getUrlImg = "";
      await uploadTask.whenComplete(() async {
        getUrlImg = await reference.getDownloadURL();
      });

      return getUrlImg;
    } on FirebaseException catch (error) {
      print("error loaded: ${error.message}");
      return "Error";
    }
  }

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<String> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Login Success";
    } on firebase_auth.FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "Account or password is not precision.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(error.code);
      return errorMessage;
    }
  }

  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password, required String name, required int phone}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
      {_postDetailsToFirebase(
          email: email,
          name: name,
          phone: phone,
          uid: value.user!.uid
      )});

      return "Register Success";
    } on firebase_auth.FirebaseAuthException catch (error) {
      print(error.code);
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "email-already-in-use":
          errorMessage = "Your email already exists.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
      currentUser = UserModel.empty;
    } catch (_) {}
  }

  _postDetailsToFirebase(
      {required String email, required String uid, required int phone, required String name}) async {
    UserModel userModel = UserModel(
      id: uid,
      email: email,
      phone: phone,
      name: name,
    );
    await _firebaseFiretore.collection("users")
        .doc(uid)
        .set(userModel.toJson());
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, email: email,);
  }
}
