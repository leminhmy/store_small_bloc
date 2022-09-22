import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/map/map_repository.dart';
import 'package:store_small_bloc/views/account/cubit/account_cubit.dart';
import 'package:store_small_bloc/views/cart/cart.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';
import 'package:store_small_bloc/views/widget/show_snack_bar.dart';

import '../../../core/type/enum.dart';
import '../../widget/app_error_widget.dart';
import '../../widget/app_loading_widget.dart';


class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    print("rebuild cart view");
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if(state.messError != ""){
          if(state.status == StatusType.init){
            ShowSnackBarWidget.showSnackCustom(isError: true,context: context,text: state.messError);
          }else{
            ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.messError);
          }
        }

      },
      child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) => false,
          builder: (context,state) {
            return const CartPage();

          }
      ),
    );
  }
}