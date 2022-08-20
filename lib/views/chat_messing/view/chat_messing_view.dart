import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';
import 'package:store_small_bloc/views/chats/chats.dart';

import '../../../models/user_model.dart';


class ChatMessingView extends StatelessWidget {
  const ChatMessingView({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMessingCubit(),
      child: ChatMessingPage(yourUser: userModel,),
    );
  }
}