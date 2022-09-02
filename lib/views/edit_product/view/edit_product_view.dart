import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/views/edit_product/edit_product.dart';

import '../../../repositories/products/product_repository.dart';



class EditProductView extends StatelessWidget {
  const EditProductView({Key? key, required this.product}) : super(key: key);

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProductCubit(products: product,productRepository: ProductRepository()),
      // child: ShowBottomSheetEditProduct.openBottomSheet(context: context, product: product);
    );
  }
}