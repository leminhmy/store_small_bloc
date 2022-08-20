import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';

import '../../../app/utils/colors.dart';
import '../../../models/messages.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../components/messaging_cart.dart';

class ChatMessingPage extends StatefulWidget {
  const ChatMessingPage({Key? key, required this.yourUser}) : super(key: key);

    final UserModel yourUser;

  @override
  State<ChatMessingPage> createState() => _ChatMessingPageState();
}

class _ChatMessingPageState extends State<ChatMessingPage> {
  String messaging = "";
  final ImagePicker _picker = ImagePicker();
  XFile? fileImage;
  XFile? fileImageSend;
  int statusSend = 0;
  TextEditingController typeMessaging = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ChatMessingCubit, ChatMessingState>(
      builder: (context, state) {

        List<MessagesModel> listMessages = state.listMess;
        return Scaffold(
          appBar: buildAppBar(size),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            //get api
                            ...List.generate(listMessages.length, (index) => MessagesCart(messagesModel: listMessages[index], userId: listMessages[index].idSend!,)),


                            //local send
                            Padding(
                              padding: EdgeInsets.only(right: size.height * 0.01,bottom: size.height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  messaging!= ""?Container(
                                      margin: EdgeInsets.only(top: size.height * 0.01),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.height * 0.02,
                                          vertical: size.height * 0.01
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(size.height * 0.015),
                                      ),
                                      child: BigText(text: messaging,color: Colors.black,)):Container(),
                                  SizedBox(height: size.height * 0.01,),
                                  fileImageSend != null?Container(
                                    height: size.height * 0.15,
                                    width: size.height * 0.15,
                                    decoration: BoxDecoration(
                                      color: AppColors.greenColor,
                                      borderRadius:
                                      BorderRadius.circular(size.height * 0.01),
                                      image: DecorationImage(
                                          image: FileImage(
                                            File(fileImageSend!.path),
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ):Container(),
                                  statusSend != 0?Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(size.height * 0.02),
                                      color: AppColors.textColor,
                                    ),
                                    child:
                                    statusSend ==1 ?Icon(Icons.upgrade_outlined,color:Colors.yellow,size: size.height * 0.018,):
                                    statusSend ==2?Icon(Icons.done_outlined,color:AppColors.mainColor,size: size.height * 0.018,):Icon(Icons.close,color:Colors.red,size: size.height * 0.018,),
                                  ):Container(),
                                  statusSend == 3?InkWell(
                                    onTap: (){
                                     /* sendMessaging(context);*/
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.height * 0.01,
                                            vertical: size.height * 0.005
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.btnClickColor,
                                          borderRadius: BorderRadius.circular(size.height * 0.005),
                                        ),
                                        child: Column(
                                          children: [
                                            SmallText(text: "Replay",color: Colors.red,),
                                          ],
                                        )),
                                  ):Container(),
                                ],
                              ),
                            ),

                          ],
                        ),
                      )),
                  buildBottomNavigator(context,size),
                ],
              ),
              fileImage != null
                  ? Positioned(
                left: size.height * 0.01,
                bottom: size.height * 0.1,
                child: Container(
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  alignment: Alignment(1.1,-1.1),
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius:
                    BorderRadius.circular(size.height * 0.01),

                    image: DecorationImage(
                        image: FileImage(
                          File(fileImage!.path),
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,size: size.height * 0.035,)
                      ,onPressed: (){
                        print('taped');
                      }),
                ),
              )
                  : Positioned( left: size.height * 0.01,
                  bottom: size.height * 0.1, child: Container()),
            ],
          ),
        );
      }
    );
  }

  buildBottomNavigator(BuildContext context, Size size) {
    return Container(
      height: size.height * 0.1,
      padding: EdgeInsets.only(left: size.height * 0.01),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(size.height * 0.02),
            topLeft: Radius.circular(size.height * 0.02),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: Colors.grey,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.mic,
            color: AppColors.mainColor,
            size: size.height * 0.026,
          ),
          SizedBox(
            width: size.height * 0.005,
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.01,
                    vertical: size.height * 0.005),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.height * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                    Expanded(
                        child: TextField(
                          controller: typeMessaging,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "Type message", border: InputBorder.none),
                        )),
                    IconButton(
                        onPressed: () {
                          imageSelect();
                        },
                        icon: Icon(Icons.image_outlined)),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                    Icon(Icons.camera_alt_outlined),
                  ],
                ),
              )),
          IconButton(
              highlightColor: Colors.red,
              onPressed: () {
               /* sendMessaging(context);*/
              },
              icon: Icon(
                Icons.send,
                color: AppColors.mainColor,
                size: size.height * 0.036,
              ))
        ],
      ),
    );
  }

  buildAppBar(Size size) {
    return AppBar(
      backgroundColor: AppColors.btnClickColor,
      title: Row(
        children: [
          widget.yourUser.image == ""?const CircleAvatar(
            backgroundImage: AssetImage("assets/images/a1.jpg"),
          ):CircleAvatar(
              backgroundColor: AppColors.mainColor,
              backgroundImage: AssetImage(widget.yourUser.image!),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          BigText(text: widget.yourUser.name!),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.local_phone)),
        IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.videocam)),
      ],
    );
  }

  void imageSelect() async {
    fileImage = null;
    fileImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
