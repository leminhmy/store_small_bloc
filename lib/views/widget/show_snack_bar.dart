import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/big_text.dart';


class ShowSnackBarWidget {


  static showSnackCustom(
      {required BuildContext context,
      bool isError = false,
      String? text}) {
    Size size = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(size.height * 0.03),
          child: SizedBox(
            height: size.height * 0.07,
            child: ColoredBox(
              color: Colors.indigo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isError
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: size.height * 0.03,
                        )
                      : Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: size.height * 0.03,
                        ),
                  BigText(text: text ?? "Add Success"),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }


}
