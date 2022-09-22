import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/widget/big_text.dart';

import '../../../app/router/route_name.dart';
import '../../../models/friend.dart';
import '../../../models/user_model.dart';
import 'friend_card.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({
    Key? key,
    required this.listFriend,
  }) : super(key: key);

  final List<Friend> listFriend;


  @override
  Widget build(BuildContext context) {
    print("rebuild list friend");
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: listFriend.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteName.messaging,
                        arguments: listFriend[index]),
                    child: FriendCard(friend: listFriend[index],index: index, routerCard: 'friend',),
                  );
                }),
          ),
          Row(
            children: [
              const Icon(Icons.emoji_people,color: Colors.black,),
              const SizedBox(width: 5,),
              BigText(text: "Bạn tương tác!",fontSize: size.height * 0.022,),
            ],
          ),

          Expanded(
            flex: 1,
            child:  BlocBuilder<ChatsCubit, ChatsState>(
                buildWhen: (previous, current) =>previous.rebuildListNotFriend != current.rebuildListNotFriend,
              builder: (context, state) {
                  print("rebuild list not friend");
                return ListView.builder(
                    itemCount: state.listNotFriend.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteName.messaging,
                            arguments: state.listNotFriend[index]),
                        child: FriendCard(friend: state.listNotFriend[index],index: index, routerCard: 'notFriend',),
                      );
                    });
              }
            ),
          ),
        ],
      ),
    );
  }
}
