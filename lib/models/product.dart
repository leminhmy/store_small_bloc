import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_small_bloc/app/utils/colors.dart';


class ProductsModel {
  String? id;
  String? name;
  String? subTitle;
  int? price;
  List<String>? listColor;
  List<int>? listSize;
  String? description;
  String? img;
  String? category;
  List<String>? listImg;
  String? createdAt;
  bool? released;
  String? updatedAt;

  ProductsModel({
    required this.id,
    this.name,
    this.subTitle,
    this.price,
    this.listColor,
    this.listSize,
    this.category,
    this.description,
    this.listImg,
    this.img,
    this.released = false,
    this.createdAt,
    this.updatedAt,
  });

  //firebase
  factory ProductsModel.formSnapshot(DocumentSnapshot snap){
    ProductsModel product = ProductsModel(
      id: snap.id,
      name: snap['name'],
      subTitle: snap['subTitle'],
      price: snap['price'],
      listColor: List<String>.from(snap['listColor']),
      listSize: List<int>.from(snap['listSize']),
      category: snap['category'],
      description: snap['description'],
      listImg: List<String>.from(snap['listImg']),
      img: snap['img'],
    );
    return product;
  }

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subTitle = json['sub_title'];
    price = json['price'];
    listColor = json['list_color'];
    listSize = json['list_size'];
    description = json['description'];
    released = json['released'];
    img = json['img'];
    listImg = json['list_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "subTitle": subTitle,
      "price": price,
      "listColor": listColor,
      "listSize": listSize,
      "category": category,
      "released": released,
      "description": description,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "img": img,
      "listImg": listImg,
    };
  }
}
List<ProductsModel> demo_products = [
  ProductsModel(
      id: "1",
      name: "product 1",
      subTitle: "subTitle",
      price: 10,
      listColor: ["0xffffffff",'0xffc70a0a'],
      listSize: [26,27,28],
      description: "description",
      img: 'assets/images/a2.png',
      listImg: ['assets/images/a2.png',]),
  ProductsModel(
      id: "2",
      name: "product 2",
      subTitle: "subTitle",
      price: 10,
      listColor: ["0xffffffff",'0xffc70a0a'],
      listSize: [26,27,28],
      description: "description",
      img: 'assets/images/a1.jpg',
      listImg: []),
  ProductsModel(
      id: "3",
      name: "product 3",
      subTitle: "subTitle",
      price: 10,
      listColor: ["0xffffffff",'0xffc70a0a'],
      listSize: [26,27,28],
      description: "description",
      img: 'assets/images/a2.png',
      listImg: []),
  ProductsModel(
      id: "4",
      name: "product 4",
      subTitle: "subTitle",
      price: 10,
      listColor: ["0xffffffff",'0xffc70a0a'],
      listSize: [26,27,28],
      description: "description",
      img: 'assets/images/a1.jpg',
      listImg: []),
  ProductsModel(
      id: "5",
      name: "product 5",
      subTitle: "subTitle",
      price: 10,
      listColor: ["0xffffffff",'0xffc70a0a'],
      listSize: [26,27,28],
      description: "description",
      img: 'assets/images/a2.png',
      listImg: []),
];
