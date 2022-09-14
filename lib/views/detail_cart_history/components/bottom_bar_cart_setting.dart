import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/detail_cart_history/detail_cart_history.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/edit_text_form.dart';

class BottomBarCartSetting extends StatefulWidget {
  const BottomBarCartSetting({Key? key, required this.totalPrice, required this.statusOrder}) : super(key: key);

  final int totalPrice;
  final int statusOrder;

  @override
  State<BottomBarCartSetting> createState() => _BottomBarCartSettingState();
}

class _BottomBarCartSettingState extends State<BottomBarCartSetting> {

  int statusOrder = 0;
  TextEditingController messenger = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    statusOrder = widget.statusOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild bottom bar cart");
    return Container(
        height: size.height * 0.25,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.01,
            vertical: size.height * 0.01),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.03),
              topRight: Radius.circular(size.height * 0.03)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatefulBuilder(
              builder: (context, setState2) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        statusOrder = 0;
                        setState2(() {});
                      },
                      child: ButtonBorderRadius(
                          colorBackground: statusOrder==0?AppColors.mainColor:Colors.white,
                          widget: Row(
                            children: [
                              const Icon(Icons.cancel,color: Colors.red,),
                              const SizedBox(width: 5,),
                              BigText(
                                text: "Cancel",

                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: (){
                        statusOrder = 1;
                        setState2(() {});
                      },
                      child: ButtonBorderRadius(
                          colorBackground: statusOrder==1?AppColors.mainColor:Colors.white,
                          widget: Row(
                            children: [
                              const Icon(Icons.update,color: Colors.yellow,),
                              const SizedBox(width: 5,),
                              BigText(
                                text: "Accept",

                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: (){
                        statusOrder = 2;
                        setState2(() {});
                      },
                      child: ButtonBorderRadius(
                          colorBackground: statusOrder==2?AppColors.mainColor:Colors.white,
                          widget: Row(
                            children: [
                              const Icon(Icons.check_circle_sharp,color: Colors.green,),
                              const SizedBox(width: 5,),
                              BigText(
                                text: "Finish",

                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                  ],
                );
              }
            ),
            EditTextForm(
                onSave: (save) => messenger.text = save!,
                controller: messenger,
                minLines: 2,
                labelText: "Messager"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonBorderRadius(
                    widget: BigText(
                      text: "Price: \$${widget.totalPrice}",

                      color: Colors.black,
                    )),

                InkWell(
                  onTap: () => context.read<DetailCartHistoryCubit>().updateStatus(statusOrder, messenger.text),
                  child: ButtonBorderRadius(
                    colorBackground: AppColors.mainColor,
                      widget: BigText(
                        text: "Save",

                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ],
        )
    );
  }
}
