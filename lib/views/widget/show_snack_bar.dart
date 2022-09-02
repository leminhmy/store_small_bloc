import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/big_text.dart';

class ShowSnackBarWidget{

  static showSnackBarDefault({required BuildContext context, required String text}){
    if (text.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: BigText(text: text,),
          ),
        );
    }
  }
}