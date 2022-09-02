import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/cart/cart.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/border_radius_widget.dart';
import '../../widget/icon_background_border_radius.dart';


class AppBarAction extends StatelessWidget {
  const AppBarAction({
    Key? key,
    required this.nameCart,
  }) : super(key: key);

  final String nameCart;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          left: size.height * 0.02,
          right: size.height * 0.02,
          top: size.height * 0.03,
          bottom: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBackgroundBorderRadius(
            icon: Icons.arrow_back_ios_outlined,
            press: () {
           Navigator.pop(context);
            },
            sizeHeight: size.height * 0.04,
            size: size.height * 0.018,
            backgroundColor: AppColors.mainColor,
            iconColor: AppColors.buttonBackgroundColor,
          ),
          Container(
            margin: EdgeInsets.only(right: size.height * 0.01),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.03,vertical: size.height * 0.01),
            decoration: BoxDecoration(
              color: AppColors.btnClickColor,
              borderRadius: BorderRadius.all(Radius.circular(size.height * 0.01)),
            ),
            child: Center(child: BigText(text: nameCart,color: Colors.white,fontSize: size.height * 0.018,fontWeight: FontWeight.bold,)),
          ),
          Row(
            children: [
              IconBackgroundBorderRadius(
                icon: Icons.home_outlined,
                press: () => Navigator.pushNamed(
                    context, RouteName.initial,
                    arguments: ""),
                sizeHeight: size.height * 0.04,
                size: size.height * 0.024,
                backgroundColor: AppColors.mainColor,
                iconColor: AppColors.buttonBackgroundColor,
              ),
              SizedBox(
                width: size.height * 0.05,
              ),
              Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                     /*   print(catController.totalItems);*/
                      },
                      child: const BorderRadiusWidget(
                          widget: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ))),
                  Positioned(
                    right: 0,top: 0,
                    child: BlocBuilder<CartCubit, CartState>(
                        buildWhen: (previous, current) => previous.rebuild != current.rebuild,
                        builder: (context, state) {
                          if(state.listCart.isNotEmpty){
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                IconBackgroundBorderRadius(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.redColor,
                                  sizeHeight: 20,
                                  press: () {},
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: BigText(text: "${state.listCart.length}",color: Colors.white,fontSize: size.height * 0.012,)),
                              ],
                            );
                          }else{
                            return const SizedBox();
                          }
                      }
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
