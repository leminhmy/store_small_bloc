import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/user_model.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFiretore;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFiretore = firebaseFirestore ?? FirebaseFirestore.instance;

  var currentUser = UserModel.empty;

  Stream<UserModel> get user{

    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      UserModel user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      try{
         _firebaseFiretore.collection("users").doc(firebaseUser!.uid).get().then((value)
        {
          user = UserModel.fromMap(value.data());
          print("user ${user.toJson()}");
          currentUser = user;
        });
      }catch(e){
        print("error $e");
      }
      return user;
    });
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
      {required String email, required String password, required String name, required String phone}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {_postDetailsToFirebase(
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
    } catch (_) {}
  }

  _postDetailsToFirebase({required String email,required String uid, required String phone, required String name}) async {
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
