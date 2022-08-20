import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/small_text.dart';


class IconAndText extends StatelessWidget {
  const IconAndText({
    Key? key, required this.text, required this.icon, required this.color,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Icon(icon,color: color,size: size.height * 0.024,),
        SizedBox(width: size.height * 0.005,),
        SmallText(text: text,),
      ],
    );
  }
}