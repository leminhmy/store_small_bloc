import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../app/utils/app_variable.dart';
import '../../../../app/utils/colors.dart';
import '../../../../models/product.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class SliderBanner extends StatefulWidget {
  const SliderBanner({
    Key? key, required this.shoesProduct,
  }) : super(key: key);

  final List<ProductsModel> shoesProduct;

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;

  double height = 0;
  double index = 0;
  double scaleFactor = 0.8;
  List<ProductsModel> shoesProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    shoesProduct = widget.shoesProduct;
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.32,
          child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: shoesProduct.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildSliderBannerCard(size,index,shoesProduct[index]);
              }),
        ),
        buildDotsIndicator(),
      ],
    );
  }

  _buildSliderBannerCard(Size size,int index, ProductsModel shoesProduct) {
    height == 0 ? size*0.32 : height;
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Padding(
        padding: EdgeInsets.only(right: size.height * 0.03),
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              //imageBackground banner
              GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                      color:
                          index.isEven ? AppColors.greenColor : const Color(0xFF9294cc),
                      image: DecorationImage(
                          /*image: AssetImage(shoesProduct.img!),*/
                          image: NetworkImage(shoesProduct.img!),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(size.height * 0.015))),
                ),
              ),

              //information banner
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(size.height * 0.02),
                  padding: EdgeInsets.only(right: size.height * 0.01,left: size.height * 0.01,top: size.height * 0.01),
                  height: size.height/9.38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.paraColor,
                        blurRadius: 10,
                        spreadRadius: -3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 0.02)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        maxLines: 1,
                        text: shoesProduct.name!,
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: size.height * 0.016,
                                    )),
                          ),
                          SizedBox(
                            width: size.height * 0.01,
                          ),
                          SmallText(text: "4.5"),
                          SizedBox(
                            width: size.height * 0.01,
                          ),
                          SmallText(text: "1287 comments"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.height * 0.05),
                  padding: EdgeInsets.all(size.height * 0.015),
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.paraColor,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius:
                    BorderRadius.all(Radius.circular(size.height * 0.02)),
                  ),
                  child: Center(
                    child: BigText(text: AppVariable.numberFormatPriceVi(shoesProduct.price!),color: Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: shoesProduct.isEmpty?1:shoesProduct.length,
      position: _currPageValue,
      decorator: DotsDecorator(
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
