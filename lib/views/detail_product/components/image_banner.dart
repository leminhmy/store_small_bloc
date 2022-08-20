import 'package:flutter/material.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/border_radius_widget.dart';

class ImageBanner extends StatefulWidget {
  const ImageBanner({
    Key? key, required this.listImg,
  }) : super(key: key);

  final List<String> listImg;

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  PageController pageController = PageController();
  int _currPageValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      _currPageValue = pageController.initialPage;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.45,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.4,
              child: PageView.builder(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.listImg.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        right: size.height * 0.005,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(size.height * 0.02),
                              bottomLeft: Radius.circular(size.height * 0.12)),
                          image: DecorationImage(
                            image: AssetImage(widget.listImg[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 10),
                              spreadRadius: -3,
                              blurRadius: 15,
                            )
                          ]),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: size.height * 0.02),
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: AppColors.redColor,
                    child: Center(
                      child: Icon(
                        Icons.favorite_outlined,
                        color: Colors.white,
                        size: size.height * 0.052,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(left: size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.005,
                    horizontal: size.height * 0.015),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.height * 0.01),
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    )),
                child: BigText(
                  text: "Page: 1/${_currPageValue+1}",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.04,
                    horizontal: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteName.initial,arguments: "",
                        ),
                        child: BorderRadiusWidget(
                            size: size.height * 0.05,
                            widget: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                            ))),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.cartPage,
                                arguments: ""),
                            child: BorderRadiusWidget(
                                size: size.height * 0.05,
                                widget: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                   const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
                                    Positioned(
                                      top: -size.height * 0.02,
                                      right: -size.height * 0.015,
                                      child: Container(
                                        height: size.height * 0.025,
                                        width: size.height * 0.025,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: BigText(
                                            text: "1",
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * 0.016),
                                      ),
                                    )
                                  ],
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
