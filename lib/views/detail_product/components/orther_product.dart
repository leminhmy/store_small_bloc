import 'package:flutter/material.dart';

import '../../../app/utils/colors.dart';
import '../../../models/product.dart';
import '../../widget/big_text.dart';


class OrtherProduct extends StatelessWidget {
  const OrtherProduct({
    Key? key, required this.listOtherProduct,
  }) : super(key: key);

  final List<ProductsModel> listOtherProduct;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.height *0.02),
          child: BigText(text: "Other Product",fontWeight: FontWeight.bold,fontSize:size.height *0.026,),
        ),
        SizedBox(
          height: size.height *0.005,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: size.height *0.015,bottom: size.height *0.02),
            child: Row(
              children: List.generate(listOtherProduct.length > 8?8:listOtherProduct.length, (index) =>
                  Container(
                    width: size.height *0.15,
                    height: size.height *0.2,
                    padding: EdgeInsets.only(right: size.height *0.01),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(size.height *0.005),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/a1.jpg'),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height *0.1,
                          child: Column(
                            children: [
                              Text(listOtherProduct[index].name!,overflow: TextOverflow.clip,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.black,
                                fontSize: size.height *0.02,
                              ),),
                              BigText(text: listOtherProduct[index].price!.toString(),fontSize: size.height *0.02,),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
