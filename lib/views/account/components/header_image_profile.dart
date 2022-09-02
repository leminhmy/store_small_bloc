import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/user_model.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/edit_text_form.dart';

class HeaderImageProfile extends StatefulWidget {
  const HeaderImageProfile({
    Key? key, required this.yourUser,
  }) : super(key: key);

  final UserModel yourUser;

  @override
  State<HeaderImageProfile> createState() => _HeaderImageProfileState();
}

class _HeaderImageProfileState extends State<HeaderImageProfile> {
  late TextEditingController phone;
  late TextEditingController name;
  XFile? _imageAvatar;
  late BuildContext dialogContext;

  final ImagePicker _picker = ImagePicker();


  void imageSelectGallery(Function(void Function()) setStateDialog) async {
    _imageAvatar = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      setStateDialog((){

      });
    });
  }
  void imageSelectCamera(Function(void Function()) setStateDialog) async {
    _imageAvatar = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      setStateDialog((){

      });
    });
  }

  @override
  void initState(){
    super.initState();
    phone = TextEditingController(text: widget.yourUser.phone);
    name = TextEditingController(text: widget.yourUser.name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        padding: EdgeInsets.all(size.height * 0.01),
        width: double.maxFinite,
        child: Center(
          child: CircleAvatar(
              maxRadius: double.maxFinite,
              backgroundColor: AppColors.mainColor,
              backgroundImage: AssetImage('assets/images/no_image.png'),
              child: GestureDetector(
                onTap: (){
                  print("taped");

                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context, setStateDialog) {

                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(
                                    horizontal: size.height * 0.01),
                                clipBehavior:
                                Clip.antiAliasWithSaveLayer,
                                title: Text('Chỉnh Sửa Thông Tin'),
                                content: SizedBox(
                                  height: size.height * 0.4,
                                  width: size.width * 0.9,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(onPressed: (){
                                            imageSelectGallery(setStateDialog);

                                          }, icon: Icon(Icons.image,size: size.height * 0.026,color: AppColors.mainColor,)),
                                          _imageAvatar !=null?CircleAvatar(
                                            maxRadius:size.height * 0.075,
                                            backgroundColor: AppColors.mainColor,
                                            backgroundImage: FileImage(
                                                File(_imageAvatar!.path)
                                            ),
                                          ):CircleAvatar(
                                            maxRadius:size.height * 0.075,
                                            backgroundColor: AppColors.mainColor,
                                            backgroundImage: AssetImage('assets/images/no_image.png'),
                                          ),
                                          IconButton(onPressed: (){
                                            imageSelectCamera(setStateDialog);

                                          }, icon: Icon(Icons.camera_alt_outlined,size: size.height * 0.026,color: AppColors.mainColor,)),
                                        ],
                                      ),
                                      EditTextForm(
                                        onSave: (save) => name.text = save!,
                                        controller: name,
                                          labelText: "Name"),
                                      SizedBox(height: size.height * 0.01,),
                                      EditTextForm(
                                          onSave: (save) => phone.text = save!,
                                        controller: phone,
                                          textInputType: TextInputType.number,
                                          labelText: "Phone"),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                         /* updateProfile(context);*/
                                        },
                                        child: ButtonBorderRadius(
                                          widget: BigText(
                                            text: "Save",
                                            color: Colors.white,
                                          ),
                                          colorBackground: AppColors.mainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      });
                },
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: AppColors.mainColor.withOpacity(0.2),
                  child: Icon(Icons.change_circle,size: size.height * 0.05,color: Colors.yellow.withOpacity(0.5),),
                ),
              )
          ),
        ));
  }
}
