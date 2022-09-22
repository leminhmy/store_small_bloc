import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/user_model.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';
import '../../widget/edit_text_form.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';
import '../cubit/account_cubit.dart';

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
    phone = TextEditingController(text: widget.yourUser.phone.toString());
    name = TextEditingController(text: widget.yourUser.name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild header_image_profile");
    return Container(
        height: size.height * 0.2,
        margin: EdgeInsets.all(size.height * 0.01),
        width: double.maxFinite,
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black12,
            image: widget.yourUser.isEmpty || widget.yourUser.image == null? const DecorationImage(
                image: AssetImage('assets/images/no_image.png'),
                fit: BoxFit.contain
            ): DecorationImage(
                image: NetworkImage(widget.yourUser.image!),
                fit: BoxFit.contain
            )
        ),
        child: Center(
          child: GestureDetector(
            onTap: (){
              openDialogUpdateUser(context: context,size: size,onPressSave: (){
                context.read<AccountCubit>().updateAccount(name: name.text, phone: phone.text,image: _imageAvatar);
              }
              );
            },
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: AppColors.mainColor.withOpacity(0.2),
              child: Icon(Icons.change_circle,size: size.height * 0.05,color: Colors.yellow.withOpacity(0.5),),
            ),
          ),
        ));
  }
  Future openDialogUpdateUser(
      {required BuildContext context, required Size size, required VoidCallback onPressSave}){

    return
      showDialog(
          context: context,
          builder: (context) {

            return StatefulBuilder(
                builder: (context, setStateDialog) {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: AlertDialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.01),
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      title: const Text('Chỉnh Sửa Thông Tin'),
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
                                  backgroundImage: const AssetImage('assets/images/no_image.png'),
                                ),
                                IconButton(onPressed: (){
                                  imageSelectCamera(setStateDialog);

                                }, icon: Icon(Icons.camera_alt_outlined,size: size.height * 0.026,color: AppColors.mainColor,)),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02,),
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
                              onTap: onPressSave,
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
                    ),
                  );
                });
          });
  }
}

