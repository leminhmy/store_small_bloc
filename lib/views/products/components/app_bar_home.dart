import 'package:flutter/material.dart';

import '../../../../app/utils/colors.dart';
import '../../../app/router/route_name.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';



class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              BigText(text: "Đức lợi Store"),
              Row(
                children: [
                  const SmallText(text: "Chi nhánh PY",),
                  Icon(Icons.arrow_drop_down_outlined,color: Colors.black,size: size.height * 0.016,),
                ],
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, RouteName.addProduct,
                    arguments: ""),
                child: Container(
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  padding: EdgeInsets.all(size.height * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(size.height * 0.01),
                  ),
                  child: Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: size.height * 0.026,
                  ),
                ),
              ),
              SizedBox(width: size.height * 0.01,),
              GestureDetector(
                /*onTap: ()=> Get.toNamed(RouteHelper.getSearchPage()),*/
                child: Container(
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  padding: EdgeInsets.all(size.height * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(size.height * 0.01),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: size.height * 0.026,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
