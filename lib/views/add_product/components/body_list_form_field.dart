
import 'package:flutter/material.dart';

import '../../widget/edit_text_form.dart';

class BodyListFormField extends StatelessWidget {
  const BodyListFormField({Key? key, required this.name, required this.subTitle, required this.price, required this.description}) : super(key: key);

  final TextEditingController name;
  final TextEditingController subTitle;
  final TextEditingController price;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        EditTextForm(
          onSave: (save) => name.text = save!,
          controller: name,
          labelText: "Name",),
        SizedBox(height: size.height * 0.01),
        EditTextForm(
            onSave: (save) => subTitle.text = save!,
            controller: subTitle,
            minLines: 2,

            labelText: "SubTitle"),
        SizedBox(
          height: size.height * 0.01,
        ),
        EditTextForm(
            onSave: (save) => price.text = save!,
            controller: price,
            textInputType: TextInputType.number,
            labelText: "Price"),
        SizedBox(
          height: size.height * 0.01,
        ),
        EditTextForm(
          onSave: (save) => description.text = save!,
          controller: description,
          minLines: 6,
          labelText: "Description",
          radiusBorder: size.height * 0.02,
        ),
      ],
    );
  }
}
