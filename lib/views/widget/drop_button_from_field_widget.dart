import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';
import '../../models/shoes_type.dart';
import 'big_text.dart';

class DropButtonFromFieldWidget extends StatefulWidget {
  const DropButtonFromFieldWidget({Key? key}) : super(key: key);

  @override
  State<DropButtonFromFieldWidget> createState() => _DropButtonFromFieldWidgetState();
}

class _DropButtonFromFieldWidgetState extends State<DropButtonFromFieldWidget> {
  String? _selectedType;
  List<String> shoesTypeList = [];
  List<ShoesTypeModel> shoesTypeListModel = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Select Type",
        labelStyle: TextStyle(
          fontSize: size.height * 0.022,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(size.height * 0.01),
          borderSide: BorderSide(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(size.height * 0.01),
          borderSide: BorderSide(
            color: AppColors.paraColor,
            width: 3,
          ),
        ),
      ),
      value: _selectedType,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        /* shoesTypeListModel.forEach((element) {
          if(element.name == newValue){
            _selectedTypeInt = element.id;
          }
        });
        setState(() {
        });*/
      },
      items: shoesTypeList.map((item) {
        return DropdownMenuItem(
          value: item,
          child:  BigText(
            text: item.replaceAll('"', ""),
            color: Colors.black,
          ),
        );
      }).toList(),
    );
  }
}