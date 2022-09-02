import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/views/edit_product/components/edit_image_product.dart';
import 'package:store_small_bloc/views/edit_product/cubit/edit_product_cubit.dart';

import '../../../app/utils/colors.dart';

class EditListImage extends StatefulWidget {
  const EditListImage({Key? key}) : super(key: key);

  @override
  State<EditListImage> createState() => _EditListImageState();
}

class _EditListImageState extends State<EditListImage> {
  PageController pageController = PageController(viewportFraction: 0.89);
  final double _currPageValue = 0;
  List<String> listImageApi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild image from dialog");
    return BlocBuilder<EditProductCubit, EditProductState>(
        buildWhen: (previousState, state) => previousState.product.listImg != state.product.listImg,
        builder: (context, state) {
          listImageApi = List.from(state.product.listImg!);
        return Column(
          children: [
            GestureDetector(
              onLongPress: () {
                ShowBottomEditImage.showBottom(context: context,product: state.product);
              },
              child: SizedBox(
                height: size.height * 0.2,
                width: size.height * 0.2,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: listImageApi.isNotEmpty?listImageApi.length:1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: size.height * 0.005),
                        decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(
                                    size.height * 0.01)),
                            image:  listImageApi.isNotEmpty?DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(listImageApi[index]),
                            ):const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/no_image.png'),
                        ),
                        ),
                      );
                    }),
              ),
            ),
            buildDotsIndicator(),
          ],
        );
      }
    );
  }



  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: listImageApi.isNotEmpty?listImageApi.length:1,
      position: _currPageValue,
      decorator: DotsDecorator(
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }


}
