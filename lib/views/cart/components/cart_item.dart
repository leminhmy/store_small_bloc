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
              /*if(page == "cartpage"){
                Get.toNamed(RouteHelper.getShoesDetail(cartModel.product!.id!, "cartpage"));
              }
              if(page == "carthistory"){
                Get.toNamed(RouteHelper.getShoesDetail(cartModel.productId!, "carthistory"));
              }*/
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
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CartCubit>().setQuantityReduceIndexCart(index);
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                              size: size.height * 0.035,
                            ),
                          ),
                          SizedBox(
                            width: size.height * 0.01,
                          ),
                          /*BlocBuilder<CartCubit, CartState>(
                              buildWhen: (previous, current) =>
                              previous.listCart[index] != current.listCart[index],
                              builder: (context,state) {
                                return BigText(text: state.listCart[index].quantity.toString());
                              }
                          ),*/
                          BlocBuilder<CartCubit, CartState>(
                              buildWhen: (previous, current) => current.indexCart == index,
                              builder: (context,state) {
                                print("da rebuild");
                                return BigText(text: state.listCart[index].quantity.toString());
                              }
                          ),
                          SizedBox(
                            width: size.height * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                             context.read<CartCubit>().setQuantityIncreaseIndexCart(index);
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.signColor,
                              size: size.height * 0.035,
                            ),
                          ),
                        ],
                      ),
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
