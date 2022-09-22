import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';
import 'package:store_small_bloc/views/chat_messing/components/app_bar_custom.dart';
import 'package:store_small_bloc/views/chat_messing/components/bottom_custom.dart';

import '../../../app/utils/colors.dart';
import '../components/list_message.dart';

class ChatMessingPage extends StatefulWidget {
  const ChatMessingPage({Key? key, required this.friend}) : super(key: key);

    final Friend friend;

  @override
  State<ChatMessingPage> createState() => _ChatMessingPageState();
}

class _ChatMessingPageState extends State<ChatMessingPage> {
  String messaging = "";
  XFile? fileImageSend;
  int statusSend = 0;
  late ChatMessingCubit chatMessingCubit;
  TextEditingController typeMessaging = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    chatMessingCubit.disposeListenMessage();
    chatMessingCubit.updateStatusMessage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild ChatMessingPage");
    chatMessingCubit = BlocProvider.of<ChatMessingCubit>(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ChatMessingCubit, ChatMessingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const PreferredSize(
              preferredSize:  Size.fromHeight(60.0),
              child:  AppBarCustom()),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                   const ListMessage(),
                    buildStatusSendMess(size),
                   const BottomCustom(),
                ],
              ),
              BlocBuilder<ChatMessingCubit, ChatMessingState>(
                  buildWhen: (previous, current) => previous.rebuildImgSelected != current.rebuildImgSelected,
                builder: (context, state) {
                    print("rebuild imgselected");
                  if(state.imgSelected != null && state.imgSelected!.path != ""){
                    return Positioned(
                      left: size.height * 0.01,
                      bottom: size.height * 0.1,
                      child: Container(
                        height: size.height * 0.15,
                        width: size.height * 0.15,
                        alignment: const Alignment(1.1,-1.1),
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius:
                          BorderRadius.circular(size.height * 0.01),

                          image: DecorationImage(
                              image: FileImage(
                                File(state.imgSelected!.path),
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,size: size.height * 0.035,)
                            ,onPressed: (){
                              context.read<ChatMessingCubit>().removeImgSelected();
                            }),
                      ),
                    );
                  }else{
                    return const Positioned(child: SizedBox());
                  }
                }
              )
            ],
          ),
        );
      }
    );
  }

  buildStatusSendMess(Size size){
    return BlocBuilder<ChatMessingCubit, ChatMessingState>(
        buildWhen: (previous, current) => previous.statusSendMess != current.statusSendMess,
      builder: (context, state) {
          print(state.statusSendMess);
        switch (state.statusSendMess) {
          case -1:
            return const SizedBox();
          case 0:
            return SizedBox(
              height: size.height * 0.025,
              width: size.height * 0.025,
                child: const CircularProgressIndicator());
          case 1:
            return const Icon(Icons.check_circle,color: Colors.green,);
          case 2:
            return const Icon(Icons.error,color: Colors.red,);
          default:
            return const SizedBox();
        }
      }
    );
  }

}


/*
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
*/
/* sendMessaging(context);*//*

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
children: const [
SmallText(text: "Replay",color: Colors.red,),
],
)),
):Container(),
],
),
),
*/
