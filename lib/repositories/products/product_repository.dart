import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/repositories/products/base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ProductRepository(
      {FirebaseFirestore? firebaseFirestore, FirebaseStorage? firebaseStorage})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<List<ProductsModel>> getAllProducts() async {
    try {
      return await _firebaseFirestore
          .collection('products')
          .get()
          .then((value) {
        return value.docs.map((e) => ProductsModel.formSnapshot(e)).toList();
      });
    } catch (error) {
      print(error.toString());
      return [];
    }
    /* return _firebaseFirestore.collection('products').snapshots().map((event) {
return event.docs.map((e) => ProductsModel.formSnapshot(e)).toList();
   });*/
  }

  Future<String> addProduct(
      ProductsModel product, List<XFile> listImages) async {
    try {
      await _firebaseFirestore
          .collection("products")
          .add(product.toJson())
          .then((value) async {
        List<String> listImgUrl =
            await uploadMultiFileImg(listImages, value.id);
        await _firebaseFirestore.collection("products").doc(value.id).update({
          "id": value.id,
          "img": listImgUrl[listImgUrl.length-1],
          "listImg": listImgUrl.sublist(0, listImgUrl.length)
        });
        print("upload info success $listImgUrl");
      });
      print("upload success");
      return "";
    } on FirebaseException catch (error) {
      print(error.code);
      print("error get Product${error.message}");
      return error.message!;
    }
  }

  Future<List<String>> uploadMultiFileImg(
      List<XFile> listImages, String idProduct) async {
    List<String> _listImageUrl = [];
    for (int i = 0; i < listImages.length; i++) {
      String imageUrl = await uploadFile(listImages[i], idProduct);
      _listImageUrl.add(imageUrl);
    }
    return _listImageUrl;
  }

  Future<String> uploadFile(XFile image, String idProduct) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("img_products")
        .child(idProduct)
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

  Future<String> setListImgProduct(String idProduct, List<String> listImgNew) async{
    try{
      await _firebaseFirestore.collection("products")
          .doc(idProduct)
          .update({"listImg":listImgNew});
      return "Success";
    } on FirebaseException catch (error){
      return "Error: ${error.message}";
    }
  }
  Future<String> updateProduct({ required Map<String, dynamic> jsonProduct}) async{
    try{
      await _firebaseFirestore.collection("products")
          .doc(jsonProduct["id"])
          .update(jsonProduct);
      return "Success";
    } on FirebaseException catch (error){
      return "Error: ${error.message}";
    }
  }
}
