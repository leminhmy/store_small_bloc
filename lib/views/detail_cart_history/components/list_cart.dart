
import 'package:flutter/material.dart';


import '../../../models/cart_model.dart';
import 'cart_item.dart';

class ListCart extends StatelessWidget {
  const ListCart({Key? key, required this.listCart}) : super(key: key);

  final List<CartModel> listCart;
  @override
  Widget build(BuildContext context) {
    print("rebuild list cart");
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
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
    );
  }

}

