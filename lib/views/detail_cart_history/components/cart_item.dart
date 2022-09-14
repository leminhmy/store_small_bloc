import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/cart_model.dart';
import 'package:store_small_bloc/views/cart/cubit/cart_cubit.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key, required this.cartModel, required this.index,
  }) : super(key: key);

  final CartModel cartModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image product
          GestureDetector(
            onTap: (){

            },
            child: Container(
              height: size.height * 0.1,
              width: size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(size.height * 0.01),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(cartModel.img!),
                )
              ),
            )
          ),
          //information product
          Expanded(
            child: Container(
              padding: EdgeInsets.all(size.height * 0.01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(size.height * 0.01)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.paraColor.withOpacity(0.1),
                      blurRadius: 1,
                    ),

                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: cartModel.name!,maxLines: 1,),
                  SizedBox(height: size.height * 0.005,),
                  Row(
                    children: [
                      const SmallText(text: "Color",color: Colors.black,),
                      SizedBox(width: size.height * 0.01,),
                      Icon(Icons.circle,size: size.height * 0.026,color: Color(int.parse(cartModel.color!)),),
                      SizedBox(width: size.height * 0.02,),
                      SmallText(text: "Size: ${cartModel.size}",color: Colors.black,),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "\$ ${cartModel.price!}",
                        color: AppColors.redColor, 
                      ),
                      BigText(text: "x${cartModel.quantity}",fontSize: size.height * 0.025,),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
