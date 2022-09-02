import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:store_small_bloc/app/utils/app_variable.dart';

import '../../app/utils/colors.dart';
import 'big_text.dart';
class PickerColorWidget extends StatefulWidget {
  const PickerColorWidget({Key? key, required this.listColors, this.listColorDefault = const []}) : super(key: key);

  final ValueChanged<List<String>> listColors;
  final List<String>? listColorDefault;

  @override
  State<PickerColorWidget> createState() => _PickerColorWidgetState();
}

class _PickerColorWidgetState extends State<PickerColorWidget> {
  List<String> listColor = [];
  Color color = const Color(0xffd11508);

  @override
  void initState() {
    // TODO: implement initState
    listColor.addAll(widget.listColorDefault!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.listColors(listColor);
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
                                String valueColor = color.toString().split('(')[1].split(')')[0];
                                if (checkWasValue(
                                    listColor, valueColor)) {
                                  AppVariable.showErrorSnackBar(context, "Color already exists");
                                } else {
                                  listColor.add(valueColor);
                                  setState(() {});
                                }
                                Navigator.of(context).pop();

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
    return listString.contains(valueString);

  }

  buildColorPicker() {
    return ColorPicker(
        pickerColor: color,
        onColorChanged: (color) {
          this.color = color;
        });
  }

}