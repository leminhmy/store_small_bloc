import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/icon_background_border_radius.dart';

class AddListImgAndThumbnail extends StatefulWidget {
  const AddListImgAndThumbnail({Key? key}) : super(key: key);

  @override
  State<AddListImgAndThumbnail> createState() => _AddListImgAndThumbnailState();
}

class _AddListImgAndThumbnailState extends State<AddListImgAndThumbnail> {
  XFile? _imageThumbnail;
  PageController pageController = PageController(viewportFraction: 0.89);
  final List<XFile> _imageList = [];
  final double _currPageValue = 0;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.height * 0.01,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(size.height * 0.01),
                      image: _imageThumbnail == null
                          ? const DecorationImage(
                        image: AssetImage(
                            "assets/images/no_image.png"),
                        fit: BoxFit.cover,
                      )
                          : DecorationImage(
                        image: FileImage(
                            File(_imageThumbnail!.path)),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    imageSelect();
                  },
                  child: ButtonBorderRadius(
                      widget: Container(
                          alignment: Alignment.center,
                          child: BigText(
                            text: "+ Image Thumbnail",
                            color: AppColors.mainColor,
                          ))),
                )
              ],
            ),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return buildAddMultiImageWidget(context,size);
                        });
                  },
                  child: SizedBox(
                    height: size.height * 0.2,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: _imageList.isNotEmpty
                            ? _imageList.length
                            : 1,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: size.height * 0.005),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        size.height * 0.01)),
                                image: _imageList.isNotEmpty
                                    ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(
                                      _imageList[index].path)),
                                )
                                    : const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/no_image.png"),
                                )),
                          );
                        }),
                  ),
                ),
                buildDotsIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildAddMultiImageWidget(BuildContext context, Size size) {
    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
            maxChildSize: 0.8,
            minChildSize: 0.1,
            initialChildSize: 0.5,
            builder: (context, _controller) {
              return StatefulBuilder(
                  builder: (context,setStateDialog) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                              children: [
                                for (int i = 0; i < _imageList.length; i++)
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
                                              image: FileImage(
                                                  File(_imageList[i].path)))),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Positioned(
                                              right: 0,
                                              top: 0,
                                              child: IconBackgroundBorderRadius(
                                                  sizeHeight: size.height * 0.03,
                                                  icon: Icons.delete_forever,
                                                  iconColor: AppColors.redColor,
                                                  press: () {
                                                    _imageList.removeAt(i);
                                                    setState(() {
                                                    });
                                                    setStateDialog(() {});
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: () {
                                    imageSelectMulti(setStateDialog);
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
                                      child: Center(
                                        child: Icon(Icons.add_outlined,
                                            size: size.height * 0.078,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }));
  }
  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: _imageList.isNotEmpty ? _imageList.length : 1,
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
  makeDismissible({required Widget child, required BuildContext context}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }


  void imageSelectMulti(void Function(void Function()) setStateDialog) async {
    List<XFile>? selectedImage = [];
    selectedImage = await _picker.pickMultiImage();
    if (selectedImage!.isNotEmpty) {
      _imageList.addAll(selectedImage);
    }
    print(selectedImage.length.toString());
    //imageString

    setStateDialog(() {});
    setState(() {});
  }

  void imageSelect() async {
    _imageThumbnail = null;
    _imageThumbnail = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
