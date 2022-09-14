
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/order.dart';

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
                await addOrderToUser(uidUser: order.userId!, idOrder: value.id, valueMap: value.data()!);
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

  Future<String> addOrderToUser({required String uidUser, required String idOrder,required Map<String, dynamic> valueMap})async{
    try{
      await _firebaseFirestore.collection("users/$uidUser/orders").doc(idOrder).set(valueMap);

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
