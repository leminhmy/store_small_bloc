import 'package:flutter/material.dart';

import '../../../app/utils/colors.dart';
import '../../../models/messages.dart';
import '../../widget/big_text.dart';


class MessagesCart extends StatelessWidget {
  const MessagesCart({
    Key? key, required this.messagesModel,
  }) : super(key: key);

  final MessagesModel messagesModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
      child: Container()/*Row(
        mainAxisAlignment: messagesModel.idSend == userId?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: messagesModel.idSend == userId?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              messagesModel.messaging!= ""?Container(
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02,
                      vertical: size.height * 0.01
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(size.height * 0.015),
                  ),
                  child: BigText(text: messagesModel.messaging!,color: Colors.black,)):Container(),
              SizedBox(height: size.height * 0.01,),
              messagesModel.image != ""?Container(
                height: size.height * 0.15,
                width: size.height * 0.15,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius:
                  BorderRadius.circular(size.height * 0.01),
                  image: DecorationImage(
                      image: AssetImage(messagesModel.image!),
                      fit: BoxFit.cover),
                ),
              ):Container(),

            ],
          ),
        ],
      ),*/,
    );
  }
}
