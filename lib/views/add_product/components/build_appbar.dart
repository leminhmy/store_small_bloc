import 'package:flutter/material.dart';

import '../../widget/big_text.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: BigText(text: "ADD Product",fontSize: size.height * 0.026),
    );
  }
}
