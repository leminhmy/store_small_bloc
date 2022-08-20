import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/cart/cart.dart';

import '../../../core/type/enum.dart';
import '../../../models/cart_model.dart';
import '../../widget/app_error_widget.dart';
import '../../widget/app_loading_widget.dart';
import '../components/app_bar_action.dart';
import '../components/bottom_bar.dart';
import '../components/list_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarAction(nameCart: "Cart"),
          BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
              previous.status != current.status,
              builder: (context,state) {
                switch (state.status) {
                  case StatusType.loading:
                    return const AppLoadingWidget();
                  case StatusType.error:
                    return const AppErrorWidget();
                  case StatusType.loaded:
                    return  ListCart(listCart: state.listCart);
                  default:
                    return const SizedBox();
                }

            }
          ),
        ],
      ),
      bottomNavigationBar: BottomBarCart(),
    );
  }
}
