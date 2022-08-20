import 'package:flutter/material.dart';

import '../../../../app/utils/app_variable.dart';
import '../../../../app/utils/colors.dart';
import '../../../../models/product.dart';
import '../../../app/router/route_name.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import 'edit_product.dart';



class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key, required this.listShoesProduct,}) : super(key: key);

  final List<ProductsModel> listShoesProduct;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DraggableScrollableController _dragScrollController =
    DraggableScrollableController();
    double maxChildeSize = 0.3;
    return Padding(
      padding:
      EdgeInsets.only(right:size.height * 0.02, left: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Popular",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: size.height * 0.026,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
            children: List.generate(listShoesProduct.length, (index) {
              return GestureDetector(
                onLongPress: () {
                  _openBottomSheet(
                    context,
                    _dragScrollController,
                    maxChildeSize,
                    listShoesProduct,
                    index,
                  );



                },
                onTap: () => Navigator.pushNamed(
                    context, RouteName.shoesDetail,
                    arguments: listShoesProduct[index]),
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.height * 0.02)),
                    child: SizedBox(
                      height: size.height * 0.25,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius:
                                BorderRadius.circular(size.height * 0.03),
                                image: DecorationImage(
                                    image: NetworkImage(listShoesProduct[index].img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.height * 0.01,vertical:size.height * 0.005 ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.height * 0.02,
                                        vertical: size.height * 0.01),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius:
                                      BorderRadius.circular(size.height * 0.01),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:size.height * 0.15,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                  maxLines: 1,
                                                  text:
                                                  listShoesProduct[index].name!,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              SmallText(
                                                maxLines: 1,
                                                text: listShoesProduct[index].subTitle ??
                                                    "None",
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Price: 150.000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                decoration:
                                                TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                              ),
                                            ),

                                            BigText(
                                              text: AppVariable.numberFormatPriceVi(
                                                  listShoesProduct[index].price!),
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height * 0.02,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: size.height * 0.075,
                                width: size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/sellera.png"),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SmallText(
                                        text: "SELL",
                                        color: Colors.amberAccent,
                                      ),
                                      BigText(
                                        text: "33%",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }


}

Future<void> _openBottomSheet(BuildContext context,DraggableScrollableController dragScrollController,double maxChildeSize,List<ProductsModel> listShoesProduct,int index){
  Widget makeDismissible(
      {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return makeDismissible(
            context: context,
            child: DraggableScrollableSheet(
                maxChildSize: 0.9,
                minChildSize: 0.1,
                initialChildSize: maxChildeSize,
                controller: dragScrollController,
                builder: (context, controller) {
                  return EditProduct(controller: controller, context: context,
                    shoesProduct: listShoesProduct[index],onTapEditText: (){
                      dragScrollController.animateTo(maxChildeSize = 0.9,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease);
                    }, );
                }));
      }).whenComplete(() => {maxChildeSize = 0.9});
}
