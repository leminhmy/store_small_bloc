import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/small_text.dart';

import 'icon_background_border_radius.dart';

class IconAndTextFullContainer extends StatelessWidget {
  const IconAndTextFullContainer({
    Key? key, required this.iconData, required this.text, required this.colorBackground, this.colorIcon = Colors.white,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final Color colorBackground;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.005,horizontal: size.height * 0.005),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconBackgroundBorderRadius(
              backgroundColor: colorBackground,
              sizeHeight: size.height * 0.06,
              iconColor: colorIcon,
              size: size.height * 0.026,
              icon: iconData,
              press: () {}),
          SizedBox(width: size.height * 0.01,),
           Expanded(
             child: SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 child: SmallText(text: text,color: Colors.black)),
           ),
        ],
      ),
    );
  }
}