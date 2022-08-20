import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';


class SmallText extends StatelessWidget {
  const SmallText({
    Key? key, required this.text, this.fontSize = 16, this.color, this.maxLines=3,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final Color? color;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(text,maxLines: maxLines,style: TextStyle(
      color: color??AppColors.textColor,
      fontSize: fontSize??size.height * 0.016,
      overflow: TextOverflow.clip,
    ),
    );
  }
}