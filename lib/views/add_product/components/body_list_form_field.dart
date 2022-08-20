import 'package:flutter/material.dart';

import '../../widget/edit_text_form.dart';
class BodyListFormField extends StatefulWidget {
  const BodyListFormField({Key? key}) : super(key: key);

  @override
  State<BodyListFormField> createState() => _BodyListFormFieldState();
}

class _BodyListFormFieldState extends State<BodyListFormField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: "name");
    TextEditingController subTitle = TextEditingController(text: "subTitle");
    TextEditingController price = TextEditingController(text: "0.0",);
    TextEditingController description = TextEditingController(text: "description");
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        EditTextForm(controller: name, labelText: "Name",onSave: (value) => name.text = value!),
        SizedBox(height: size.height * 0.01),
        EditTextForm(
            controller: subTitle,
            minLines: 2,
            onSave: (value) => subTitle.text = value!,
            labelText: "SubTitle"),
        SizedBox(
          height: size.height * 0.01,
        ),
        EditTextForm(
            onSave: (value) => price.text = value!,
            controller: price,
            textInputType: TextInputType.number,
            labelText: "Price"),
        SizedBox(
          height: size.height * 0.01,
        ),
        EditTextForm(
          onSave: (value) => description.text = value!,
          controller: description,
          minLines: 6,
          labelText: "Description",
          radiusBorder: size.height * 0.02,
        ),
      ],
    );
  }
}
