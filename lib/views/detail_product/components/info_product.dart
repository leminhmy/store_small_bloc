import 'package:flutter/material.dart';

import '../../../app/utils/app_variable.dart';
import '../../../app/utils/colors.dart';
import '../../../models/product.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';


class InfoProduct extends StatelessWidget {
  const InfoProduct({
    Key? key, required this.shoesProduct, required this.onChangeSize, required this.onChangeColor,
  }) : super(key: key);

  final ProductsModel shoesProduct;

  final ValueChanged<int> onChangeSize;
  final ValueChanged<String> onChangeColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int selectedColor = 0;
    int selectedSize = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: shoesProduct.name!,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.026,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) =>
                        Padding(
                          padding: EdgeInsets.only(right: size.height * 0.005),
                          child: Icon(Icons.star, color: Colors.yellow,
                            size: size.height * 0.026,),
                        )),
                  ),
                  SizedBox(
                    width: size.height * 0.01,
                  ),
                  SmallText(text: "4.0", fontSize: size.height * 0.02,),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.height * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size.height * 0.025), bottomLeft: Radius.circular(size.height * 0.025)),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.grey,
                        )
                    ),
                    child: Center(child: Row(
                      children: [
                        BigText(text: AppVariable.numberFormatPriceVi(shoesProduct.price!),
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,),
                      ],
                    )),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              BigText(text: "Description"),
              SmallText(
                  text: shoesProduct.description!),
              SizedBox(
                height: size.height * 0.01,
              ),

            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: size.height * 0.02),
          child: BigText(text: "Size"),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        StatefulBuilder(
          builder: (context,setState2) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: size.height * 0.015),
                child: Row(
                  children: List.generate(shoesProduct.listSize!.length, (index) =>
                      GestureDetector(
                        onTap: (){
                          selectedSize = index;
                          onChangeSize(shoesProduct.listSize![index]);
                          setState2((){});

                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: size.height * 0.005),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(size.height * 0.04),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.textColor,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                  )
                                ],
                                border: Border.all(
                                  color:  selectedSize==index?AppColors.mainColor:AppColors.textColor,
                                  width: 2,
                                )
                            ),
                            child: Center(
                              child: BigText(text: shoesProduct.listSize![index].toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            );
          }
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.only(left: size.height * 0.02),
          child: BigText(text: "Color"),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        StatefulBuilder(
          builder: (context, setState2) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: size.height * 0.015),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(shoesProduct.listColor!.length, (index) =>
                          GestureDetector(
                            onTap: (){
                              selectedColor = index;
                              onChangeColor(shoesProduct.listColor![index]);
                              setState2((){});
                             /* shoesController.changeOptionColor(listColor[index]);*/
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: size.height * 0.01),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Color(int.parse(shoesProduct.listColor![index])),
                                    border: Border.all(
                                      color: selectedColor==index?AppColors.mainColor:Colors.transparent,
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(size.height * 0.005),
                                    image: DecorationImage(

                                        image: AssetImage("assets/images/a2.png"),
                                        fit: BoxFit.contain
                                    )
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}
