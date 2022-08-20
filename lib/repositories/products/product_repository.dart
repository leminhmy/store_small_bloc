import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/repositories/products/base_product_repository.dart';

class ProductRepository extends BaseProductRepository{

  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore}):
        _firebaseFirestore = firebaseFirestore??FirebaseFirestore.instance;
  @override
  Stream<List<ProductsModel>> getAllProducts() {
   return _firebaseFirestore.collection('products').snapshots().map((event) {
return event.docs.map((e) => ProductsModel.formSnapshot(e)).toList();
   });
  }

}