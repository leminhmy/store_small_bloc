import 'package:flutter/material.dart';


class ButtonBorderRadius extends StatelessWidget {
  const ButtonBorderRadius({
    Key? key, required this.widget, this.colorBackground = Colors.white, this.borderRadius,
  }) : super(key: key);

  final Widget widget;
  final Color colorBackground;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(size.height * 0.015),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius??size.height * 0.02)),
        ),
        child: widget
    );
  }
}