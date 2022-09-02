import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/edit_product/components/edit_list_image.dart';
import 'package:store_small_bloc/views/edit_product/cubit/edit_product_cubit.dart';

import '../../../app/utils/colors.dart';
import '../../../models/product.dart';
import '../../../repositories/products/product_repository.dart';
import '../../products/cubit/filter_product_cubit.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/drop_button_from_field_widget.dart';
import '../../widget/edit_text_form.dart';
import '../../widget/picker_color.dart';
import '../../widget/picker_size.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';
import '../../widget/swich_and_title.dart';

class ShowBottomSheetEditProduct {
  static Future<void> openBottomSheet(
      {required BuildContext context,
      double maxChildSize = 0.3,
      required ProductsModel product}) {
    final DraggableScrollableController dragScrollController =
        DraggableScrollableController();
    Widget makeDismissible(
            {required Widget child, required BuildContext context}) =>
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
                    if (previousState.onTapEvent != state.onTapEvent) {
                      dragScrollController.animateTo(maxChildSize = 0.9,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease);
                    }
                    return false;
                  }, builder: (context, state) {
                    return DraggableScrollableSheet(
                        maxChildSize: 0.9,
                        minChildSize: 0.1,
                        initialChildSize: maxChildSize,
                        controller: dragScrollController,
                        builder: (context, controller) {
                          return EditProductPage(
                            controller: controller,
                          );
                        });
                  }),
                ),
              ));
        }).whenComplete(() => {maxChildSize = 0.9});
  }

  static openDialogConfirm(
      {required BuildContext context, required Size size}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.height * 0.01),
              ),
              title: Row(
                children: const [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Warning"),
                ],
              ),
              content: const Text("You want delete it!"),
              actions: [
                TextButton(
                    onPressed: () {
                      /*  deleteProduct(productsModel.id!);*/
                    },
                    child: const Text("Delete")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              ],
            ));
  }
}

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key, required this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: ColoredBox(
          color: Colors.yellow,
          child: SingleChildScrollView(
            controller: controller,
            child: const EditProductBody(),
          ),
        ),
      ),
    );
  }
}

class EditProductBody extends StatelessWidget {
  const EditProductBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        BuildHeaderWidget(),
        BuildBodyWidget(),
      ],
    );
  }
}

class BuildHeaderWidget extends StatelessWidget {
  const BuildHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: EditListImage(),
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
                  onTap: () {
                    context.read<EditProductCubit>().onTapEvent();
                    print("tapded");
                  },
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
                    ShowBottomSheetEditProduct.openDialogConfirm(
                        context: context, size: size);
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

class BuildBodyWidget extends StatefulWidget {
  const BuildBodyWidget({Key? key}) : super(key: key);

  @override
  State<BuildBodyWidget> createState() => _BuildBodyWidgetState();
}

class _BuildBodyWidgetState extends State<BuildBodyWidget> {
  TextEditingController name = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  ProductsModel productEdit = ProductsModel(id: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("test open keyboard body");

    return BlocBuilder<EditProductCubit, EditProductState>(
        buildWhen: (previousState, state) {
         return false;
        },
        builder: (context, state) {
          productEdit.id = state.product.id!;
          name.text = state.product.name!;
          subTitle.text = state.product.subTitle!;
          price.text = state.product.price!.toString();
          description.text = state.product.description!;
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
                builder: (context, state2) {
              return DropButtonFromFieldWidget(
                valueDefault: state.product.category!,
                shoesTypeListModel: state2.listShoesType,
                valueSelected: (String valueSelected) {
                  productEdit.category = valueSelected;
                },
              );
            }),
            PickerColorWidget(
              listColorDefault: state.product.listColor,
              listColors: (List<String> listColors) {
                productEdit.listColor = listColors;
                print(listColors);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            PickerSizeWidget(
              listSizeDefault: state.product.listSize,
              listSize: (List<int> listSize) {
                productEdit.listSize = listSize;
                print(listSize);
              },
            ),
            SwitchAndTitle(
              defaultValue: state.product.released!,
              value: (bool value) {
                productEdit.released = value;
                print(value);
              },
            ),
            GestureDetector(
                onTap: () {
                  productEdit.name = name.text;
                  productEdit.subTitle = subTitle.text;
                  productEdit.price = int.parse(price.text.isEmpty?state.product.price!.toString():price.text);
                  productEdit.description = description.text;
                  productEdit.updatedAt = DateTime.now().toString();
                  context.read<EditProductCubit>().updateProduct(productEdit);
                },
                child: ButtonBorderRadius(
                    widget: BigText(
                  text: "Save",
                ))),
          ],
        ),
      );
    });
  }
}


