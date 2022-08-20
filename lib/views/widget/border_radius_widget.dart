import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';


class BorderRadiusWidget extends StatelessWidget {
  const BorderRadiusWidget({
    Key? key, this.size, this.colorBackground, required this.widget, this.radius,
  }) : super(key: key);

  final double? size;
  final Color? colorBackground;
  final Widget widget;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: this.size??size.height * 0.04,
      width: this.size??size.height * 0.04,
      decoration: BoxDecoration(
          color: colorBackground??AppColors.mainColor,
          borderRadius: BorderRadius.circular(radius??size.height * 0.03)
      ),
      child: Center(child: widget)
    );
  }
}
