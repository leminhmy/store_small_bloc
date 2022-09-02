import 'package:store_small_bloc/models/product.dart';

abstract class BaseProductRepository{
  Future<List<ProductsModel>> getAllProducts();
}