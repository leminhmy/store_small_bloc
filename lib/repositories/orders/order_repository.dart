
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/order.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/notification_service/notification_repository.dart';

class OrderRepository {
  final FirebaseFirestore _firebaseFirestore;

  OrderRepository(
      {FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  Future<String> addOrder(Order order) async{
    try{
      if(order.userId != null){
        await _firebaseFirestore
            .collection("orders").add(order.toJson()).then((value) {
              value.update({"id":value.id});
              value.get().then((value) async{
                await addOrderToUser(uidUser: order.userId!, order: Order.fromJson(value.data()!));
              });
        });

        print("addOrder success");
        return "Success";
      }else{
        return "error: order";
      }

    } on FirebaseException catch(error){
      print("addOrder error ${error.message}");
      return "Error: ${error.message}";
    }
  }

  Future<String> addOrderToUser({required String uidUser,required Order order})async{
    try{
      await _firebaseFirestore.collection("users/$uidUser/orders").doc(order.id).set(order.toJson());
      List<String> listNameOrder = List.generate(order.orderItems!.length, (index) => order.orderItems![index].name!);
      AuthRepository().sendNotification(AuthRepository.allTokenMessAdmin, "New Order: ${order.id}", "Gồm: $listNameOrder");
      return "Success";
    } on FirebaseException catch(error){
      return "Error: ${error.message}";
    }
  }

  Future<String> updateOrder(Order newOrder)async{
    try{
      Map<String, dynamic> mapOrder = newOrder.toJson()..removeWhere((key, value) => value == null || value == "");
      await _firebaseFirestore.collection("orders")
          .doc(newOrder.id)
          .update(mapOrder);
      await _firebaseFirestore.collection("users")
          .doc(newOrder.userId).collection("orders").doc(newOrder.id)
          .update(mapOrder);
      await _firebaseFirestore.collection("users").doc(newOrder.userId).get().then((value) {
        UserModel user = UserModel.fromMap(value.data());
        String statusOrder = "";
        if(newOrder.status == 0){
          statusOrder = "Cancel";
        }else if(newOrder.status == 1){
          statusOrder = "Accept";
        }else if(newOrder.status == 2){
          statusOrder = "Finish";
        }
        AuthRepository().sendNotification([user.tokenMessages!], "Order Id: ${newOrder.id}", "Cập nhật trạng thái order: $statusOrder");

      });
      print("update success");
      return "";
    } on FirebaseException catch(error){
      print("update error ${error.message}");
      return "Error: ${error.message}";
    }
  }
  
  Stream<List<Order>> getOrderUser(String uid){

  return  _firebaseFirestore.collection("users").doc(uid).collection("orders")
      .snapshots().map((event) {
        print("getOrderUser changed");
    return event.docs.map((e) => Order.formSnapshot(e)).toList();
  });

  }

  Stream<List<Order>> getOrderAdmin(){

    return  _firebaseFirestore.collection("orders").orderBy("createdAt",descending: true)
        .snapshots().map((event) {
      print("getOrderUser changed");
      return event.docs.map((e) => Order.formSnapshot(e)).toList();
    });

  }

}
