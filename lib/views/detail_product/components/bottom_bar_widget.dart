import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/detail_product/detail_product.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/border_radius_widget.dart';


class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key, required this.onPressCheckOut,
  }) : super(key: key);

  final VoidCallback onPressCheckOut;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(size.height * 0.02),
          topLeft: Radius.circular(size.height * 0.02),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005,horizontal: size.height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.02),
              border: Border.all(
                color: Colors.white,
                width: 1,
              )
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    context.read<DetailProductCubit>().changeCurrentReduce();
                  },
                  child: BorderRadiusWidget(
                    colorBackground: AppColors.greenColor,
                    widget: Icon(
                      Icons.remove_outlined,
                      color: Colors.white,
                      size: size.height * 0.026,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.height * 0.01,
                ),
                BlocBuilder<DetailProductCubit,DetailProductState>(
                    buildWhen: (previous, current) =>
                    previous.current != current.current,
                  builder: (context,state) {
                    return BigText(
                      text: "x${state.current}",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.026,
                    );
                  }
                ),
                SizedBox(
                  width: size.height * 0.01,
                ),
                InkWell(
                  onTap: (){
                    context.read<DetailProductCubit>().changeCurrentIncrease();
                  },
                  child: BorderRadiusWidget(
                    colorBackground: AppColors.greenColor,
                    widget: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                      size: size.height * 0.026,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onPressCheckOut,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01,horizontal: size.height * 0.02),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(size.height * 0.02),
              ),
              child: BigText(
                text: "Add to cart",
                color: Colors.white,
                fontSize: size.height * 0.026,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
