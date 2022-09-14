import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.01),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: listFriend.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteName.messaging,
                        arguments: demo_listUser[index]),
                    child: FriendCard(friend: listFriend[index],index: index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
