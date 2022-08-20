import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';


class IconBackgroundBorderRadius extends StatelessWidget {
  const IconBackgroundBorderRadius({
    Key? key,
    required this.icon,
    this.backgroundColor,
    this.size ,
    required this.press, this.iconColor = Colors.black, this.sizeHeight,
  }) : super(key: key);

  final IconData icon;
  final Color? backgroundColor;
  final double? size;
  final VoidCallback press;
  final Color? iconColor;
  final double? sizeHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size.height * 0.02)),
      onTap: press,
      child: SizedBox(
        height: sizeHeight??size.height * 0.05,
        width: sizeHeight??size.height * 0.05,
        child: CircleAvatar(
          backgroundColor: backgroundColor??AppColors.buttonBackgroundColor,

          child: Icon(
            icon,
            size: this.size??size.height * 0.024,
            color: iconColor??AppColors.signColor,
          ),
        ),
      ),
    );
  }
}