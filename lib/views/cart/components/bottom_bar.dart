import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/views/account/cubit/account_cubit.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../cubit/cart_cubit.dart';

class BottomBarCart extends StatelessWidget {
  const BottomBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild bottom bar cart");
    return Container(
      height: size.height * 0.12,
      padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.height * 0.03),
            topRight: Radius.circular(size.height * 0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //quantity
          BlocBuilder<CartCubit, CartState>(
              builder: (context,state) {
                print('rebuild bottom');
                return ButtonBorderRadius(
                    widget: BigText(
                      text: "\$ ${context.read<CartCubit>().getTotalPriceListCart()}",

                      color: Colors.black,
                    ));
              }
          ),
          //addToCard
          BlocBuilder<GoogleMapCubit, GoogleMapState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<CartCubit>().checkOutOrder(state.address);
                },
                child: ButtonBorderRadius(
                  widget: BigText(
                    text: "Check out",
                    color: Colors.white,
                  ),
                  colorBackground: AppColors.mainColor,
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
