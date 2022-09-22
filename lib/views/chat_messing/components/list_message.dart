import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_messing_cubit.dart';
import 'messaging_cart.dart';

class ListMessage extends StatelessWidget {
  const ListMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatMessingCubit, ChatMessingState>(
          buildWhen: (previous, current) =>previous.rebuild != current.rebuild,
          builder: (context, state) {
            print("rebuild list message");
            print(state.listMessage.length);
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: state.listMessage.length,
                itemBuilder: (context, index) => MessagesCart(messagesModel: state.listMessage[index], uidUser: state.uibUser,));
          }
      ),
    );
  }
}
