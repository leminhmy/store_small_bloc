import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../cubit/detail_product_cubit.dart';
import 'detail_product_page.dart';

class DetailProductView extends StatelessWidget {
  const DetailProductView({Key? key, required this.productsModel}) : super(key: key);
  final ProductsModel productsModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailProductCubit(productsModel: productsModel)..detailLoading(),
      child:  const DetailProductPage(),
    );
  }
}