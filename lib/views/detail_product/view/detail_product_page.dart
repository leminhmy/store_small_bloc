import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/cart_model.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/views/detail_product/cubit/detail_product_cubit.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../widget/show_snack_bar.dart';
import '../components/bottom_bar_widget.dart';
import '../components/image_banner.dart';
import '../components/info_product.dart';
import '../components/orther_product.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<DetailProductCubit, DetailProductState>(
        buildWhen: (previous, current) =>
            previous.productsModel != current.productsModel,
        builder: (context, state) {

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageBanner(
                    listImg: state.productsModel.listImg!,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoProduct(
                    shoesProduct: state.productsModel,
                    onChangeSize: (int value) => context.read<DetailProductCubit>().changeSize(value),
                    onChangeColor: (String value) => context.read<DetailProductCubit>().changeColor(value),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  OrtherProduct(listOtherProduct: demo_products),
                ],
              ),
            ),
            bottomNavigationBar: BottomBarWidget(
              onPressCheckOut: () async{
                ShowSnackBarWidget.showSnackCustom(context: context);
                CartModel cartModel = context.read<DetailProductCubit>().cartOption();
                await context.read<CartCubit>().addCart(cartModel);

              },
            ),
          );
        });
  }
}
