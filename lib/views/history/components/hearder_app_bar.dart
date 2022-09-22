import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/history/history.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_background_border_radius.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key? key, required this.namePage,
  }) : super(key: key);

  final String namePage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      color: AppColors.mainColor,
      padding: EdgeInsets.only(top: size.height * 0.045),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BigText(
            text: namePage,
            color: Colors.white,
            fontSize: size.height * 0.026,
          ),
          IconBackgroundBorderRadius(
            icon: Icons.shopping_cart_outlined,
            press: () {
              context.read<HistoryCubit>().testListOrder();
            },
            size: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
