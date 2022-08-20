
import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/picker_color.dart';
import 'package:store_small_bloc/views/widget/picker_size.dart';
import 'package:store_small_bloc/views/widget/swich_and_title.dart';

import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/drop_button_from_field_widget.dart';
import '../components/add_list_img_and_thumbnail.dart';
import '../components/body_list_form_field.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: BigText(text: "ADD Product",fontSize: size.height * 0.026),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            color: Colors.yellow,
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(size.height * 0.02), topLeft: Radius.circular(size.height * 0.02))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AddListImgAndThumbnail(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                child: Column(
                  children: [
                    BodyListFormField(),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    DropButtonFromFieldWidget(),
                    PickerColorWidget(),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    PickerSizeWidget(),
                    SwitchAndTitle(),
                    GestureDetector(
                        onTap: () {
                         /* uploadFileImg(context);*/
                        },
                        child: ButtonBorderRadius(
                            widget: BigText(
                              text: "Save",
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




