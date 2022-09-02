import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? id;
  String? name;
  int? price;
  String? img;
  String? color;
  int? size;
  String? idOrder;
  int? quantity;
  String? idProduct;
  String? createdAt;
  String? updatedAt;


  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.color,
        this.size,
        this.idOrder,
        this.quantity,
        this.idProduct,
        this.createdAt,
        this.updatedAt,
      });

  factory CartModel.formSnapshot(DocumentSnapshot snap){
    CartModel cartModel = CartModel(
      id: snap.id,
      name: snap["name"],
      price: snap["price"],
      img: snap["img"],
      color: snap["color"],
      size: snap["size"],
      idOrder: snap["idOrder"],
      quantity: snap["quantity"],
      idProduct: snap["idProduct"],
      createdAt: snap['createdAt'],
      updatedAt: snap['updatedAt'],
    );
    return cartModel;
  }

  factory CartModel.fromMap(Map<String, dynamic> snap){
    CartModel cartModel = CartModel(
      id: snap["id"],
      name: snap["name"],
      price: snap["price"],
      img: snap["img"],
      color: snap["color"],
      size: snap["size"],
      idOrder: snap["idOrder"],
      quantity: snap["quantity"],
      idProduct: snap["idProduct"],
      createdAt: snap['createdAt'],
      updatedAt: snap['updatedAt'],
    );
    return cartModel;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    color = json['color'];
    size = json['size'];
    idOrder = json['id_order'];
    quantity = json['quantity'];
    idProduct = json['id_product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "color":this.color,
      "size":this.size,
      "quantity":this.quantity,
      "idProduct":this.idProduct,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };

  }


}

List<CartModel> demo_listcart = [

];

