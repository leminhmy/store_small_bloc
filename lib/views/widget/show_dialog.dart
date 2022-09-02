import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/big_text.dart';

import '../../core/type/enum.dart';

class ShowDialogWidget{

  static void showCustomDialog(BuildContext context, {String? text,bool status = false, Widget? widget }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: status,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 240,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child:  Scaffold(body:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget??const CircularProgressIndicator(),
                  const SizedBox(height: 10,),
                  BigText(text: text??"UpLoading",),
                ],
              ),
            )),

          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static openDialogConfirm(
      {required BuildContext context, required Size size,required String mess, required VoidCallback changeConfirm}) {
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
          content: Text(mess),
          actions: [
            TextButton(
                onPressed: changeConfirm,
                child: const Text("Delete")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        ));
  }

  static showDialogDefaultBloc(
      {required BuildContext context, required StatusType status, required String text}){
    if(status == StatusType.loading){
      return ShowDialogWidget.showCustomDialog(context);
    }else if(status == StatusType.loaded){
      Navigator.pop(context);
      return ShowDialogWidget.showCustomDialog(context,status: true,text: text,widget: const Icon(Icons.check_circle_rounded,color: Colors.green,size: 40,));
    }else if(status == StatusType.error){
      Navigator.pop(context);
      return ShowDialogWidget.showCustomDialog(context,status: true,text: text,widget: const Icon(Icons.error,color: Colors.red,size: 40,));
    }
  }
}
