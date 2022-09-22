import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';

import '../../../app/utils/colors.dart';
import '../../widget/big_text.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = window.physicalSize;
    return BlocBuilder<ChatMessingCubit, ChatMessingState>(
      builder: (context, state) {
        return AppBar(
          backgroundColor: AppColors.btnClickColor,
          title: Row(
            children: [
              state.friend.image == ""?const CircleAvatar(
                backgroundImage: AssetImage("assets/images/a1.jpg"),
              ):CircleAvatar(
                backgroundColor: AppColors.mainColor,
                backgroundImage: NetworkImage(state.friend.image!),
              ),
              SizedBox(
                width: size.height * 0.01,
              ),
              BigText(text: state.friend.name!),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.local_phone)),
            IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.videocam)),
          ],
        );
      }
    );
  }
}

