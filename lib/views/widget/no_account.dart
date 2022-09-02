import 'package:flutter/material.dart';

import '../../app/router/route_name.dart';
import '../../app/utils/colors.dart';
import 'big_text.dart';

class NoAccountWidget extends StatelessWidget {
  const NoAccountWidget({Key? key}) : super(key: key);

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
                image: AssetImage("assets/images/signintocontinue.png"),
              )
          ),
        ),
        GestureDetector(
          onTap: ()=>Navigator.pushNamed(
              context, RouteName.logIn,
              arguments: ""),
          child: Container(
            width: double.maxFinite,
            height: size.height * 0.1,
            margin: EdgeInsets.only(left: size.height * 0.02,right: size.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(size.height * 0.02),
            ),
            child: Center(child: BigText(text: "Sign in",color: Colors.white,fontSize: size.height * 0.026,)),
          ),
        ),
      ],
    );
  }
}
