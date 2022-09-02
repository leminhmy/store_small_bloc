import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';

import '../../../models/product.dart';
import '../../products/cubit/filter_product_cubit.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/drop_button_from_field_widget.dart';
import '../../widget/picker_color.dart';
import '../../widget/picker_size.dart';
import '../../widget/swich_and_title.dart';
import '../cubit/add_product_cubit.dart';
import 'add_list_img_and_thumbnail.dart';
import 'body_list_form_field.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  TextEditingController name = TextEditingController(text: "name");
  TextEditingController subTitle = TextEditingController(text: "subTitle");
  TextEditingController price = TextEditingController(
    text: "0",
  );
  TextEditingController description =
      TextEditingController(text: "description");
  ProductsModel product = ProductsModel(id: "",createdAt: DateTime.now().toString());
  List<XFile> listImages = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AddListImgAndThumbnail(
          listImg: (List<XFile> listImgSelected) {
            if (listImgSelected.isNotEmpty) {
              listImages = listImgSelected;
            }
            // print("ListImg: ${listImgSelected.length}");
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
          child: Column(
            children: [
              BodyListFormField(
                name: name,
                description: description,
                price: price,
                subTitle: subTitle,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              BlocBuilder<FilterProductCubit, FilterProductState>(
                  builder: (context, state) {
                    product.category = state.listShoesType[0].name;
                return DropButtonFromFieldWidget(
                  shoesTypeListModel: state.listShoesType,
                  valueSelected: (String valueSelected) {
                    product.category = valueSelected;
                    print(valueSelected);
                  },
                );
              }),
              PickerColorWidget(
                listColors: (List<String> listColors) {
                  product.listColor = listColors;
                  print(product.listColor);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              PickerSizeWidget(
                listSize: (List<int> listSize) {
                  product.listSize = listSize;
                  print(listSize);
                },
              ),
              SwitchAndTitle(
                value: (bool value) {
                  print(value);
                  product.released = value;
                },
              ),
              GestureDetector(
                  onTap: () async {
                    product.name = name.text;
                    product.subTitle = subTitle.text;
                    product.price = int.parse(price.text.isEmpty?"-1":price.text);
                    product.description = description.text;
                    product.createdAt = DateTime.now().toString();
                    product.updatedAt = DateTime.now().toString();
                    await context.read<AddProductCubit>().addProductNew(product,listImages);
                  },
                  child: ButtonBorderRadius(
                      widget: BigText(
                    text: "Save",
                  ))),
            ],
          ),
        ),
      ],
    );
  }
}
