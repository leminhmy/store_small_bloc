
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
    const AppTextField({
    Key? key,
    required this.textFieldController, required this.prefixIcon, this.colorIcon = Colors.grey,
     required this.hintText, this.isObscure = false, this.suffixIcon, this.textInputType, required this.onSave,
  }) : super(key: key);

  final TextEditingController textFieldController;
  final IconData prefixIcon;
  final Color colorIcon;
  final String hintText;
  final bool isObscure;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final ValueChanged<String?> onSave;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.height * 0.03),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(1, 5),
                color: Colors.grey.withOpacity(0.2),
              ),
            ]
        ),
        child: TextFormField(
          autofocus: false,
          obscureText: isObscure?true:false,
          controller: textFieldController,
          textInputAction: TextInputAction.done,
          onSaved: (save)=>onSave(save),
          maxLines: 1,
          keyboardType: textInputType??TextInputType.multiline,
          decoration: InputDecoration(

            suffixIcon: suffixIcon,
              hintText: hintText,
              prefixIcon: Icon(prefixIcon,color: colorIcon,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.height * 0.03),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.height * 0.03),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.height * 0.03),
              )
          ),
        )
    );
  }
}
