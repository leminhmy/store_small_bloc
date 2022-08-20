
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoesTypeModel{
  String? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  ShoesTypeModel({
    required this.id,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  factory ShoesTypeModel.formSnapshot(DocumentSnapshot snap){
    ShoesTypeModel shoesType = ShoesTypeModel(
      id: snap.id,
      name: snap['name'],
    );
    return shoesType;
  }

  ShoesTypeModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['title'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.name,
      "parentId": this.parentId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}



List<ShoesTypeModel> demo_shoetype = [
  ShoesTypeModel(id: "1",name: "Sport Shoes",parentId: 0,),
  ShoesTypeModel(id: "2",name: "Leather Shoes",parentId: 0,),
  ShoesTypeModel(id: "3",name: "Ex Shoes",parentId: 0,),
  ShoesTypeModel(id: "4",name: "QQ Shoes",parentId: 0,),
];