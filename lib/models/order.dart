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
    this.message,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'];
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = <CartModel>[];
      json['order_items'].forEach((v) {
        orderItems!.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userId": this.userId,
      "orderAmount": this.orderAmount,
      "phone": this.phone,
      "status": this.status,
      "address": this.address,
      "message": this.message,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
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
