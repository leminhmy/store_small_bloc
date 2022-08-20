import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';
import 'big_text.dart';

class SwitchAndTitle extends StatefulWidget {
  const SwitchAndTitle({
    Key? key,
  }) : super(key: key);


  @override
  State<SwitchAndTitle> createState() => _SwitchAndTitleState();
}

class _SwitchAndTitleState extends State<SwitchAndTitle> {
  bool releasedProduct = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: BigText(
          text: "Released",
          color: AppColors.blackColor,
        ),
        value: releasedProduct,
        onChanged: (bool value) {
          releasedProduct = value;
          setState(() {

          });
        });
  }
}