import 'package:flutter/material.dart';
import 'package:store_small_bloc/app/utils/colors.dart';



class BigText extends StatelessWidget {
   BigText({
    Key? key, required this.text, this.fontSize, this.color, this.fontWeight = FontWeight.w500, this.maxLines = 3,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(text,maxLines: maxLines,style: TextStyle(
      color: color??AppColors.mainColor,
      fontSize: fontSize??size.height * 0.018,
      fontWeight: FontWeight.w500,
    ));
  }
}