import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../app/utils/colors.dart';
import 'big_text.dart';
class PickerColorWidget extends StatefulWidget {
  const PickerColorWidget({Key? key}) : super(key: key);

  @override
  State<PickerColorWidget> createState() => _PickerColorWidgetState();
}

class _PickerColorWidgetState extends State<PickerColorWidget> {
  List<String> listColor = [];
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        BigText(
          text: "Color: ",
          color: Colors.black,
          fontSize: size.height * 0.022,
        ),
        SizedBox(
          width: size.height * 0.01,
        ),
        for (int i = 0; i < listColor.length; i++)
          Stack(
            children: [
              Icon(Icons.circle,
                  size: size.height * 0.052,
                  color: Color(int.parse(listColor[i]))),
              Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      listColor.removeAt(i);
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 10,
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                        size: size.height * 0.024,
                      ),
                    ),
                  )),
            ],
          ),
        SizedBox(
          width: size.height * 0.01,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: SizedBox(
                      height: size.height * 0.7,
                      child: AlertDialog(
                        title: Text('Pick Your Color'),
                        content: Column(
                          children: [
                            buildColorPicker(),
                            TextButton(
                              child: BigText(
                                text: "SELECT",
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                String colorString = color
                                    .toString(); // Color(0x12345678)
                                String valueColor = colorString
                                    .split('(')[1]
                                    .split(')')[0];
                                if (checkWasValue(
                                    listColor, valueColor)) {
                                  print('error selected color');
                                } else {
                                  listColor.add(valueColor);
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Container(
            height: size.height * 0.04,
            width: size.height * 0.04,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(size.height * 0.01),
                color: Colors.white),
            child: Icon(
              Icons.add_outlined,
              color: AppColors.mainColor,
              size: size.height * 0.039,
            ),
          ),
        )
      ],
    );

  }

  bool checkWasValue(List<String> listString, String valueString) {
    final index = listString.indexOf(valueString);
    if (index == -1) {
      return false;
    }
    return true;
  }

  buildColorPicker() {
    return ColorPicker(
        pickerColor: color,
        onColorChanged: (color) {
          this.color = color;
        });
  }

}