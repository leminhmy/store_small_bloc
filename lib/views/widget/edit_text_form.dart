import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';



class EditTextForm extends StatelessWidget {
  const EditTextForm({
    Key? key, this.minLines = 1, required this.labelText, this.fillColor = Colors.white, this.radiusBorder, required this.controller, this.textInputType=TextInputType.multiline, required this.onSave,
  }) : super(key: key);

  final int minLines;
  final String labelText;
  final Color fillColor;
  final double? radiusBorder;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String?> onSave;

  @override
  Widget build(BuildContext context) {
    print("rebuild widget editextfrom: $labelText");
    Size size = MediaQuery.of(context).size;
    return TextFormField(
        controller: controller,
        minLines: minLines, // any number you need (It works as the rows for the textarea)
        keyboardType: textInputType,
        maxLines: null,
        validator: (value){
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please Enter Your $labelText");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid $labelText(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (save){
          print("onSave");
          onSave(save);
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: "$labelText...",
          labelStyle: TextStyle(
            fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: fillColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder??size.height * 0.01),
            borderSide: BorderSide(
              color: AppColors.mainColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder??size.height * 0.01),
            borderSide: BorderSide(
              color:AppColors.paraColor,
              width: 3,
            ),
          ),
        )
    );
  }
}
