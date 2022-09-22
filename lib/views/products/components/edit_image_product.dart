import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/product.dart';

import '../../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/icon_background_border_radius.dart';

class EditImageProduct extends StatefulWidget {
  const EditImageProduct({Key? key, required this.controller, required this.shoesProduct}) : super(key: key);

  final ScrollController controller;
  final ProductsModel shoesProduct;


  @override
  State<EditImageProduct> createState() => _EditImageProductState();

}

class _EditImageProductState extends State<EditImageProduct> {
  final ImagePicker _picker = ImagePicker();
  List<String> listImgApi = [];
  String listImgApiBase = '';
  List<XFile>? _imageList = [];
  String imgApiString = '';
  late BuildContext dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: SingleChildScrollView(
        controller: widget.controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: [
                for(int i = 0; i < listImgApi.length; i++)
                  listImgApi.isNotEmpty?Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: Container(
                      height: size.height * 0.1,
                      width: size.height * 0.12,
                      decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.01)),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/a1.jpg'),
                          )),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                              right: 0,
                              top: 0,
                              child: IconBackgroundBorderRadius(
                                  sizeHeight: size.height * 0.03,
                                  icon: Icons.delete_forever,iconColor: AppColors.redColor,
                                  press: (){

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext contextDialog)

                                        {
                                          return AlertDialog(
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  size.height * 0.01),
                                            ),
                                            title: Row(
                                              children: const [
                                                Icon(
                                                  Icons
                                                      .warning_amber_rounded,
                                                  color:
                                                  Colors.yellow,
                                                ),
                                                Text("Warning"),
                                              ],
                                            ),
                                            content: Text(
                                                "You want delete it!"),
                                            actions: [
                                              TextButton(
                                                  onPressed:()
                                                      {
                                                  },
                                                  child: Text(
                                                      "Delete")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        contextDialog);
                                                  },
                                                  child: Text(
                                                      "Cancel")),
                                            ],
                                          );
                                        });


                                  })),
                        ],
                      ),
                    ),
                  ):Container(),
                for(int i = 0; i < _imageList!.length; i++)
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: Container(
                      height: size.height * 0.1,
                      width: size.height * 0.12,
                      decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.01)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(_imageList![i].path))
                          )),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                              right: 0,
                              top: 0,
                              child: IconBackgroundBorderRadius(
                                  sizeHeight: size.height * 0.03,
                                  icon: Icons.delete_forever,iconColor: AppColors.redColor, press: (){
                                _imageList!.removeAt(i);
                                setState(() {

                                });
                              })),
                        ],
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: (){
                    imageSelect();
                  },

                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: Container(
                      height: size.height * 0.1,
                      width: size.height * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.height * 0.01)),
                      ),
                      child: Center(child: Icon(Icons.add_outlined,size: size.height * 0.08,color: Colors.black),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: ()async{

                          },
                          child: ButtonBorderRadius(widget: BigText(text: "Save",))),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> convertDataStringToList(String dataString) {
    List<String> listData = [];
    listData = (dataString.split(','));
    return listData;
  }

  void imageSelect()async{
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    if(selectedImage!.isNotEmpty){
      _imageList!.addAll(selectedImage);
    }
    print(selectedImage.length.toString());
    setState(() {
    });
  }


}
