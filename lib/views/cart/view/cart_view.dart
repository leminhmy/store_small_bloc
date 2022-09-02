import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/cart/cart.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';

import '../../../core/type/enum.dart';
import '../../widget/app_error_widget.dart';
import '../../widget/app_loading_widget.dart';


class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if(state.messError != ""){
            // ShowDialogWidget.openDialogConfirm(context: context, size: size, mess: state.messError, changeConfirm: (){
            //     print("play ");
            //     Navigator.pop(context);
            //     context.read<CartCubit>().removeCartInList(state.indexCart);
            // });
          }
        },
      child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) =>
          previous.status != current.status,
          builder: (context,state) {
            switch (state.status) {
              case StatusType.loading:
                return const Scaffold(body: AppLoadingWidget());
              case StatusType.error:
                return const Scaffold(body: AppErrorWidget());
              case StatusType.loaded:
                return CartPage();
              default:
                return const SizedBox();
            }

          }
      ),
    );
  }
}