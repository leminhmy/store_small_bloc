import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/products/product_repository.dart';

import '../cubit/add_product_cubit.dart';
import 'add_product_page.dart';



class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(productRepository: ProductRepository()),
      child: const AddProductPage(),
    );
  }
}