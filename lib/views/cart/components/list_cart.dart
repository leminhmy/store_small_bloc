import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/widget/empty_box.dart';
import '../../../models/cart_model.dart';
import '../../widget/big_text.dart';
import '../cubit/cart_cubit.dart';
import 'cart_item.dart';

class ListCart extends StatelessWidget {
  const ListCart({Key? key}) : super(key: key);
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
          BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
              previous.rebuild != current.rebuild,
              builder: (context,state) {
                print("rebuild listCart");
                if(state.listCart.isNotEmpty){
                  return Column(
                    children: List.generate(
                      state.listCart.length,
                          (index) =>
                          GestureDetector(
                            onTap: (){

                            },
                            child: CartItem(cartModel: state.listCart[index],index: index),
                          ),
                    ),
                  );
                }else{
                  return const EmptyBoxWidget();
                }
            }
          ),
        ],
      ),
    );
  }

}

