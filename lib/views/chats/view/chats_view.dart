import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/chat/chat_repository.dart';
import 'package:store_small_bloc/views/chats/chats.dart';

import '../../../core/type/enum.dart';
import '../../widget/app_loading_widget.dart';
import '../../widget/no_account.dart';


class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
        buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case StatusType.init:
            return const Scaffold(body: Center(child: NoAccountWidget()),);
          case StatusType.loading:
            return const AppLoadingWidget();
          case StatusType.loaded:
            return ChatsPage(listFriend: state.isFriend?state.listPeople:state.listFriend,);
          default:
            return const SizedBox();
        }
      }
    );
  }
}