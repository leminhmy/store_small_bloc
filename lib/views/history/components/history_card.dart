import 'package:flutter/material.dart';

import '../../../app/utils/app_variable.dart';
import '../../../app/utils/colors.dart';
import '../../../models/order.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    print('rebuild widget');
    Size size = MediaQuery.of(context).size;
    List<Widget> listStatusProduct = [
      Row(
        children: [
          const Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          const SmallText(text: "Cancel"),
        ],
      ),
      Row(
        children: [
          const Icon(
            Icons.update,
            color: Colors.yellow,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          const SmallText(text: "Accept"),
        ],
      ),
      Row(
        children: [
          const Icon(
            Icons.done_outline,
            color: Colors.green,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          SmallText(text: "Finished"),
        ],
      ),
      Row(
        children: [
          const Icon(
            Icons.new_releases,
            color: Colors.yellow,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          const SmallText(text: "Chờ duyệt"),
        ],
      ),
    ];
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(bottom: size.height * 0.02),
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.005,
                        horizontal: size.height * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius:
                      BorderRadius.circular(size.height * 0.005),
                    ),
                    child: BigText(text: "ID: ${order.id}",color: AppColors.redColor,),

                  ),
                  SizedBox(width: size.height * 0.01),
                  BigText(text: AppVariable.timeFormat(order.updatedAt!)),
                  listStatusProduct[order.status!],
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                        order.orderItems!.length, (index) {
                      return index <= 1
                          ? Container(
                        height: size.height * 0.08,
                        width: size.height * 0.08,
                        margin:
                        EdgeInsets.only(right: size.height * 0.005),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                size.height * 0.007),
                            image: DecorationImage(
                                image: AssetImage('assets/images/a1.jpg'),
                                fit: BoxFit.cover)),
                      )
                          : Container();
                    }),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SmallText(text: "Total:", color: AppColors.titleColor),
                            SizedBox(width: size.height * 0.01,),
                            BigText(
                              text:
                              "${order.orderItems!.length} Items",
                              color: AppColors.titleColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SmallText(text: "Price:", color: AppColors.titleColor),
                            SizedBox(width: size.height * 0.01,),
                            BigText(
                              text: AppVariable.numberFormatPriceVi(order.orderAmount!),
                              color: AppColors.titleColor,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {

                           /* // test
                            List<dynamic> cartModelHistory =
                            getCartHistoryList[i].orderItems!;

                            Get.toNamed(
                                RouteHelper.getCartPage("carthistory", index: i));*/
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005,
                                horizontal: size.height * 0.01),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.mainColor,
                                width: 1,
                              ),
                              borderRadius:
                              BorderRadius.circular(size.height * 0.005),
                            ),
                            child: SmallText(
                              text: "one more",
                              color: AppColors.mainColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              order.message != null?ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                horizontalTitleGap: 0.0,
                minLeadingWidth: 0,
                child: ExpansionTile(
                  title: BigText(text: "Message",color: AppColors.redColor,),
                  children: [
                    BigText(text: order.message!,color: Colors.black,),
                  ],
                ),
              ):Container(),
            ],
          ),
        );
      }
    );
  }

}
