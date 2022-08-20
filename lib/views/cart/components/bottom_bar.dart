import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../cubit/cart_cubit.dart';

class BottomBarCart extends StatelessWidget {
  const BottomBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              buildWhen: (previous, current) =>
              previous.listCart[0] != current.listCart [0],
              builder: (context,state) {
                print('rebuild bottom');
                return SizedBox();
              }
          ),
          ButtonBorderRadius(
              widget: BigText(
                text: "\$9999",
                color: Colors.black,
              )),
          //addToCard
          GestureDetector(
            onTap: () {

            },
            child: ButtonBorderRadius(
              widget: BigText(
                text: "Check out",
                color: Colors.white,
              ),
              colorBackground: AppColors.mainColor,
            ),
          )
        ],
      ),
    );
  }
}
