import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';
import 'big_text.dart';

class SwitchAndTitle extends StatefulWidget {
  const SwitchAndTitle({
    Key? key, required this.value,this.defaultValue = false,
  }) : super(key: key);

  final ValueChanged<bool> value;
  final bool defaultValue;


  @override
  State<SwitchAndTitle> createState() => _SwitchAndTitleState();
}

class _SwitchAndTitleState extends State<SwitchAndTitle> {
  bool releasedProduct = false;

  @override
  void initState() {
    // TODO: implement initState
    releasedProduct = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.value(releasedProduct);
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