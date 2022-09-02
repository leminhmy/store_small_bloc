import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/repositories/products/product_repository.dart';
import 'package:store_small_bloc/views/edit_product/cubit/edit_product_cubit.dart';

import '../../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/icon_background_border_radius.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';

class ShowBottomEditImage{

  static showBottom({required BuildContext context, required ProductsModel product}){
    makeDismissible({required Widget child, required BuildContext context}) =>
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return makeDismissible(
              context: context,
              child: BlocProvider(
                create: (context) => EditProductCubit(products: product,productRepository: ProductRepository()),
                child: BlocListener<EditProductCubit, EditProductState>(
                  listener: (context, state) {
                    ShowSnackBarWidget.showSnackBarDefault(context: context, text: state.messError);
                    ShowDialogWidget.showDialogDefaultBloc(context: context,status: state.status,text: state.messError);
                  },
                  child: BlocBuilder<EditProductCubit, EditProductState>(
                      buildWhen: (previousState, state) {
                        return false;
                      }, builder: (context, state) {
                      return DraggableScrollableSheet(
                          maxChildSize: 0.8,
                          minChildSize: 0.1,
                          initialChildSize: 0.5,
                          builder: (context, controller) {
                            return EditImageProduct(
                              controller: controller,
                              listImgApi: state.product.listImg!,
                            );
                          });
                    }
                  ),
                ),
              ));
        });

  }

}

class EditImageProduct extends StatelessWidget {
  const EditImageProduct({Key? key, required this.controller, required this.listImgApi}) : super(key: key);
  final ScrollController controller;
  final List<String> listImgApi;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: ColoredBox(
        color: Colors.yellow,
        child: SingleChildScrollView(
          controller: controller,
          child:  BuildBody(listImgDefault: listImgApi),
        ),
      ),
    );
  }
}


class BuildBody extends StatefulWidget {
  const BuildBody({Key? key, required this.listImgDefault}) : super(key: key);

  final List<String> listImgDefault;

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  final ImagePicker _picker = ImagePicker();
  List<String> listImgApi = [];
  List<XFile>? _imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    listImgApi = List.from(widget.listImgDefault);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          children: [
            for(int i = 0; i < listImgApi.length; i++)
              Padding(
                padding: EdgeInsets.all(size.height * 0.005),
                child: Container(
                  height: size.height * 0.1,
                  width: size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(size.height * 0.01)),
                      image:  DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(listImgApi[i]),
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
                                listImgApi.removeAt(i);
                                setState(() {

                                });
                              })),
                    ],
                  ),
                ),
              ),
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
                      onTap: (){
                        context.read<EditProductCubit>().editImageProduct(listImgUrl: listImgApi, newListImgXFile: _imageList!);
                      },
                      child: ButtonBorderRadius(widget: BigText(text: "Save",))),

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

   showDialogConfirm(Size size){
    return showDialog(
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
            content: const Text(
                "You want delete it!"),
            actions: [
              TextButton(
                  onPressed:()
                  {
                  },
                  child:const Text(
                      "Delete")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(
                        contextDialog);
                  },
                  child:const Text(
                      "Cancel")),
            ],
          );
        });
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
