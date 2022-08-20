import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/views/chats/chats.dart';


class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(),
      child:  ChatsPage(listMess: demo_messages,listUser: demo_listUser,),
    );
  }
}