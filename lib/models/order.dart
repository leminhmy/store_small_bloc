import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_model.dart';

class OrderList {
  int? _totalSize;
  late List<Order> _orders;

  List<Order> get orders => _orders;

  OrderList({required totalSize, required orders}) {
    this._totalSize = totalSize;
    this._orders = orders;
  }

  OrderList.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['orders'] != null) {
      _orders = <Order>[];
      json['orders'].forEach((v) {
        _orders.add(Order.fromJson(v));
      });
    }
  }
}

class Order {
  String? id;
  String? userId;
  int? orderAmount;
  int? phone;
  int? status;
  String? address;
  String? message;
  String? createdAt;
  String? updatedAt;
  List<CartModel>? orderItems;

  Order({
    this.id,
    this.userId,
    this.orderAmount,
    this.phone,
    this.status,
    this.address,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  static final empty =  Order();
  bool get isEmpty => this == Order.empty;
  bool get isNotEmpty => this != Order.empty;

  factory Order.formSnapshot(DocumentSnapshot snap){
    Order order = Order(
      id: snap.id,
      userId: snap['userId'],
      orderAmount: snap['orderAmount'],
      phone: snap['phone'],
      status: snap['status'],
      address: snap['address'],
      message: snap['message'],
      createdAt: snap['createdAt'],
      updatedAt: snap['updatedAt'],
      orderItems: List<Map<String, dynamic>>.from(snap['orderItems']).map((e) => CartModel.fromMap(e)).toList(),
    );
    return order;
  }

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    orderAmount = json['orderAmount'];
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderItems = List<Map<String, dynamic>>.from(json['orderItems']).map((e) => CartModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "orderAmount": orderAmount,
      "phone": phone,
      "status": status,
      "address": address,
      "message": message,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "orderItems": orderItems?.map((e) => e.toJson()).toList(),
    };
  }
}




List<Order> demo_order = [
  Order(
      id: "1",
      userId: "1",
      orderAmount: 9999,
      phone: 123456879,
      status: 1,
      message: "Test",
      createdAt: "2022-08-11 10:20:10",
      updatedAt: "2022-08-11 10:20:10",
      orderItems: [
        CartModel(
            id: "1",
            idOrder: "1",
            idProduct: "1",
            name: "product1",
            img: 'assets/images/a1.jpg',
            color: '0xffffffff',
            size: 20,
            quantity: 3,
            price: 2000,
            createdAt: "2022-08-11 10:20:10",
            updatedAt: "2022-08-11 10:20:10",
        ),
        CartModel(
          id: "2",
          idOrder: "1",
          idProduct: "1",
          name: "product1",
          img: 'assets/images/a1.jpg',
          color: '0xffffffff',
          size: 20,
          quantity: 3,
          price: 2000,
          createdAt: "2022-08-11 10:20:10",
          updatedAt: "2022-08-11 10:20:10",
        ),
        CartModel(
          id: "3",
          idOrder: "1",
          idProduct: "1",
          name: "product1",
          img: 'assets/images/a1.jpg',
          color: '0xffffffff',
          size: 20,
          quantity: 3,
          price: 2000,
          createdAt: "2022-08-11 10:20:10",
          updatedAt: "2022-08-11 10:20:10",
        ),
      ]),
  Order(
      id: "2",
      userId: "1",
      orderAmount: 9999,
      phone: 123456879,
      status: 1,
      createdAt: "2022-08-11 10:20:10",
      updatedAt: "2022-08-11 10:20:10",
      orderItems: [
        CartModel(
          id: "1",
          idOrder: "1",
          idProduct: "1",
          name: "product1",
          img: 'assets/images/a1.jpg',
          color: '0xffffffff',
          size: 20,
          quantity: 3,
          price: 2000,
          createdAt: "2022-08-11 10:20:10",
          updatedAt: "2022-08-11 10:20:10",
        ),
        CartModel(
          id: "2",
          idOrder: "1",
          idProduct: "1",
          name: "product1",
          img: 'assets/images/a1.jpg',
          color: '0xffffffff',
          size: 20,
          quantity: 3,
          price: 2000,
          createdAt: "2022-08-11 10:20:10",
          updatedAt: "2022-08-11 10:20:10",
        ),
        CartModel(
          id: "3",
          idOrder: "1",
          idProduct: "1",
          name: "product1",
          img: 'assets/images/a1.jpg',
          color: '0xffffffff',
          size: 20,
          quantity: 3,
          price: 2000,
          createdAt: "2022-08-11 10:20:10",
          updatedAt: "2022-08-11 10:20:10",
        ),
      ]),
];
