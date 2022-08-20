import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/repositories/category/base_category_repository.dart';
import 'package:store_small_bloc/repositories/products/base_product_repository.dart';

import '../../models/shoes_type.dart';

class CategoryRepository extends BaseCategoryRepository{

  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore}):
        _firebaseFirestore = firebaseFirestore??FirebaseFirestore.instance;
  @override
  Stream<List<ShoesTypeModel>> getAllShoesType() {
    return _firebaseFirestore.collection('category').snapshots().map((event) {
      return event.docs.map((e) => ShoesTypeModel.formSnapshot(e)).toList();
    });
  }

}