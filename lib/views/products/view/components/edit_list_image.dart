import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../app/utils/colors.dart';
import '../../../../models/product.dart';
import '../../components/edit_image_product.dart';

class EditListImage extends StatefulWidget {
  const EditListImage({Key? key, required this.shoesProduct}) : super(key: key);

  final ProductsModel shoesProduct;

  @override
  State<EditListImage> createState() => _EditListImageState();
}

class _EditListImageState extends State<EditListImage> {
  PageController pageController = PageController(viewportFraction: 0.89);
  final double _currPageValue = 0;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return makeDismissible(
                      context: context,
                      child: DraggableScrollableSheet(
                          maxChildSize: 0.8,
                          minChildSize: 0.1,
                          initialChildSize: 0.5,
                          builder: (context, _controller) {
                            return EditImageProduct(
                              controller: _controller,
                              shoesProduct: widget.shoesProduct,
                            );
                          }));
                });
          },
          child: SizedBox(
            height: size.height * 0.2,
            width: size.height * 0.2,
            child: PageView.builder(
                controller: pageController,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        right: size.height * 0.005),
                    decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(
                                size.height * 0.01)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/a1.jpg')
                        )),
                  );
                }),
          ),
        ),
        buildDotsIndicator(),
      ],
    );
  }

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

  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: widget.shoesProduct.listImg!.isNotEmpty?widget.shoesProduct.listImg!.length:1,
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
