import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/utils/colors.dart';
import 'big_text.dart';


class PickerSizeWidget extends StatefulWidget {
  const PickerSizeWidget({Key? key}) : super(key: key);

  @override
  State<PickerSizeWidget> createState() => _PickerSizeWidgetState();
}

class _PickerSizeWidgetState extends State<PickerSizeWidget> {
  List<String> listSize = [];
  String sizeIndexPicker = '20';
  List<String> pickItemsSize = List.generate(20, (index) => (20+index).toString());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        BigText(
          text: "Size: ",
          color: Colors.black,
          fontSize: size.height * 0.022,
        ),
        SizedBox(
          width: size.height * 0.01,
        ),
        for (int i = 0; i < listSize.length; i++)
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: size.height * 0.005,
                    top: size.height * 0.005),
                child: Container(
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          size.height * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                          blurRadius: 2,
                        )
                      ],
                      border: Border.all(
                        color: AppColors.textColor,
                        width: 1,
                      )),
                  child: Center(
                    child: BigText(
                      text: listSize[i].toString(),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      listSize.removeAt(i);
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 10,
                      child: Icon(
                        Icons.highlight_remove,
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
                      height: size.height * 0.5,
                      child: AlertDialog(
                        title: Text('Pick Your Size'),
                        content: StatefulBuilder(builder: (context, setStateDialog) {
                          return Column(
                            children: [
                              buildSizePicker(setStateDialog),
                              Row(
                                children: [
                                  BigText(
                                    text: "Add: ",
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: size.height * 0.01,
                                  ),
                                  BigText(
                                      text: "Size " +
                                          sizeIndexPicker),
                                ],
                              ),
                              TextButton(
                                child: BigText(
                                  text: "SELECT",
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (checkWasValue(listSize,
                                      sizeIndexPicker)) {
                                    print(
                                        "Error: Size already exists");
                                  } else {
                                    listSize.add(sizeIndexPicker);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          );
                        }),
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
  buildSizePicker(StateSetter setStateDialog) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          sizeIndexPicker = pickItemsSize[index];
          setStateDialog(() {
          });
        },
        children: pickItemsSize
            .map((item) => Center(
          child: BigText(
            text: item,
          ),
        ))
            .toList(),
      ),
    );
  }

}