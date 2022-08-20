import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/cart_model.dart';
import '../../widget/big_text.dart';
import '../cubit/cart_cubit.dart';
import 'cart_item.dart';

class ListCart extends StatelessWidget {
  const ListCart({Key? key, required this.listCart}) : super(key: key);
  final List<CartModel> listCart;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          /*BlocBuilder<CartCubit,  CartState>(
              buildWhen: (previous, current) =>
              previous.indexCart != current.indexCart,
            builder: (context,state) {
              print('rebuild Cart');
              return SizedBox();
            }
          ),*/
          BigText(text: "Địa Chỉ: "),
          Column(
            children: List.generate(
              listCart.length,
                  (index) =>
                  GestureDetector(
                      onTap: (){

                      },
                      child: CartItem(cartModel: listCart[index],index: index),
            ),
          ),
          ),
        ],
      ),
    );
  }

}

