import 'package:flutter/material.dart';



class EmptyBoxWidget extends StatelessWidget {
  const EmptyBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: size.height * 0.2,
          margin: EdgeInsets.only(left: size.height * 0.02,right: size.height * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.02),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/empty_box.png"),
              )
          ),
        ),
      ],
    );
  }
}
