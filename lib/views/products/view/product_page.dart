import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/models/shoes_type.dart';
import 'package:store_small_bloc/views/products/cubit/filter_product_cubit.dart';
import 'package:store_small_bloc/views/products/products.dart';
import 'package:store_small_bloc/views/widget/app_loading_widget.dart';

import '../../../app/router/route_name.dart';
import '../../../core/type/enum.dart';
import '../../widget/app_error_widget.dart';
import '../components/app_bar_home.dart';
import '../components/category.dart';
import '../components/popular_product.dart';
import '../components/slider_banner.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.yellow,
        onRefresh: () async {
          Navigator.pushNamed(
              context, RouteName.initial,
              arguments: "");
          context.read<FilterProductCubit>().loadingProducts();

        },
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBarHome(),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    BlocBuilder<ProductCubit,ProductState>(
                        buildWhen: (previous, current) =>
                        previous.status != current.status,
                      builder: (context,state) {
                        switch (state.status) {
                          case StatusType.loading:
                            return const AppLoadingWidget();
                          case StatusType.error:
                            return const AppErrorWidget();
                          case StatusType.loaded:
                            return SliderBanner(shoesProduct: state.listProductBanner);
                          default:
                            return const SizedBox();
                        }
                      }
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Category(
                      onChange: (index){
                        context.read<FilterProductCubit>().filterProducts(index);
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    BlocBuilder<FilterProductCubit,FilterProductState>(
                        buildWhen: (previous, current) =>
                        previous.status != current.status,
                        builder: (context,state) {

                          print(state.listShoesType.length);
                          switch (state.status) {
                            case StatusType.loading:
                              return const AppLoadingWidget();
                            case StatusType.error:
                              return const AppErrorWidget();
                            case StatusType.loaded:

                              return PopularProducts(
                                listShoesProduct: state.listProduct,
                              );
                            default:
                              return const SizedBox();
                          }
                        }
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
