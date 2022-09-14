import 'package:flutter/material.dart';


import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';

class BottomBarCart extends StatelessWidget {
  const BottomBarCart({Key? key, required this.totalPrice}) : super(key: key);

  final int totalPrice;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild bottom bar cart");
    return Container(
      height: size.height * 0.12,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.height * 0.03),
            topRight: Radius.circular(size.height * 0.03)),
      ),
      child: ButtonBorderRadius(
          widget: BigText(
            text: "TotalPrice: \$$totalPrice",

            color: Colors.black,
          ))
    );
  }
}
