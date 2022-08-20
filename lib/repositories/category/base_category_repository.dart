import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/models/shoes_type.dart';

abstract class BaseCategoryRepository{
  Stream<List<ShoesTypeModel>> getAllShoesType();
}