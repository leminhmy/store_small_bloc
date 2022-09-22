import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';

import '../../../app/utils/colors.dart';

class BottomCustom extends StatefulWidget {
  const BottomCustom({Key? key}) : super(key: key);

  @override
  State<BottomCustom> createState() => _BottomCustomState();
}

class _BottomCustomState extends State<BottomCustom> {
  TextEditingController typeMessaging = TextEditingController();
   final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      padding: EdgeInsets.only(left: size.height * 0.01),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(size.height * 0.02),
            topLeft: Radius.circular(size.height * 0.02),
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: Colors.grey,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.mic,
            color: AppColors.mainColor,
            size: size.height * 0.026,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.01,
                    vertical: size.height * 0.005),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.height * 0.04),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sentiment_satisfied_alt_outlined),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                    Expanded(
                        child: TextField(
                          controller: typeMessaging,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              hintText: "Type message", border: InputBorder.none),
                        )),
                    IconButton(
                        onPressed: () {
                          imageSelect();
                        },
                        icon: const Icon(Icons.image_outlined)),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                    const Icon(Icons.camera_alt_outlined),
                  ],
                ),
              )),
          IconButton(
              highlightColor: Colors.red,
              onPressed: () {
                context.read<ChatMessingCubit>().sendMessage(typeMessaging.text);
                typeMessaging.text = "";
                setState(() {
                });
              },
              icon: Icon(
                Icons.send,
                color: AppColors.mainColor,
                size: size.height * 0.036,
              ))
        ],
      ),
    );
  }

  void imageSelect() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {

      context.read<ChatMessingCubit>().selectedImg(value!);
    });

  }
}
