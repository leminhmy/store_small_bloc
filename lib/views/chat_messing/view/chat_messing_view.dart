import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/chat/chat_repository.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';
import 'package:store_small_bloc/views/chats/chats.dart';

import '../../../models/user_model.dart';


class ChatMessingView extends StatelessWidget {
  const ChatMessingView({Key? key, required this.friend}) : super(key: key);
  final Friend friend;

  @override
  Widget build(BuildContext context) {
    print("rebuild ChatMessingView");
    return BlocProvider(
      create: (context) => ChatMessingCubit(modelFriend: friend,
          chatRepository: ChatRepository())..loadingUserModel(),
      child: ChatMessingPage(friend: friend,),
    );
  }
}