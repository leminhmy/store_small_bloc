import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/products/cubit/filter_product_cubit.dart';

import '../../../../app/utils/colors.dart';
import '../../../../models/product.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/drop_button_from_field_widget.dart';
import '../view/components/edit_list_image.dart';
import '../../widget/edit_text_form.dart';
import '../../widget/picker_color.dart';
import '../../widget/picker_size.dart';
import '../../widget/swich_and_title.dart';


class EditProduct extends StatefulWidget {
  const EditProduct(
      {Key? key,
      required this.controller,
      required this.context,
      required this.shoesProduct,  required this.onTapEditText,
    })
      : super(key: key);

  final ScrollController controller;
  final BuildContext context;
  final ProductsModel shoesProduct;
  final VoidCallback onTapEditText;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  late ProductsModel productsModel;

  @override
  void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild edit product");
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(size.height * 0.02), topLeft: Radius.circular(size.height * 0.02))),
      child: SingleChildScrollView(
        controller: widget.controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildHeader(size, context),
            const BuildBody(),
          ],
        )
      ),
    );
  }

  buildHeader(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: EditListImage(shoesProduct: demo_products[0]),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: widget.onTapEditText,
                  child: ButtonBorderRadius(
                      widget: Container(
                          alignment: Alignment.center,
                          child: BigText(
                            text: "Edit Product",
                            color: AppColors.mainColor,
                          ))),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                size.height * 0.01),
                          ),
                          title: Row(
                            children: const [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.yellow,
                              ),
                              Text("Warning"),
                            ],
                          ),
                          content: Text("You want delete it!"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  /*  deleteProduct(productsModel.id!);*/
                                },
                                child: Text("Delete")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                          ],
                        ));
                  },
                  child: ButtonBorderRadius(
                      widget: Container(
                          alignment: Alignment.center,
                          child: BigText(
                            text: "Delete Product",
                            color: AppColors.mainColor,
                          ))),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ButtonBorderRadius(
                      widget: Container(
                          alignment: Alignment.center,
                          child: BigText(
                            text: "Cancel",
                            color: AppColors.mainColor,
                          ))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key, }) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  TextEditingController name = TextEditingController();
  TextEditingController subTitle= TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return buildBody(size);
  }

  buildBody(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
      child: Column(
        children: [

          EditTextForm(
              onSave: (save) => name.text = save!,
              controller: name,
              labelText: "Name"),
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
          SizedBox(
            height: size.height * 0.01,
          ),
          BlocBuilder<FilterProductCubit, FilterProductState>(
            builder: (context, state) {
              return DropButtonFromFieldWidget(
                shoesTypeListModel: state.listShoesType,
                valueSelected: (String valueSelected){

                },
              );
            }
          ),
          PickerColorWidget(
            listColors: (List<String> listColors){
              print(listColors);
            },
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          PickerSizeWidget(
            listSize: (List<int> listSize){
              print(listSize);
            },
          ),
          SwitchAndTitle(
            value: (bool value){
              print(value);
            },
          ),
          GestureDetector(
              onTap: () {
                /* updateProduct(shoesController);*/
              },
              child: ButtonBorderRadius(
                  widget: BigText(
                    text: "Save",
                  ))),
        ],
      ),
    );
  }

}












