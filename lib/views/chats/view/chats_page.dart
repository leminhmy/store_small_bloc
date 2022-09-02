import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_small_bloc/app/utils/app_variable.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/views/chats/chats.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/time_ago.dart';
import '../../../models/messages.dart';
import '../../../models/user_model.dart';
import '../../widget/big_text.dart';
import '../../widget/search_widget.dart';
import '../../widget/small_text.dart';
import '../components/friend_card.dart';
import '../components/list_friend.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key, required this.listFriend,}) : super(key: key);

  final List<Friend> listFriend;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String query = '';
  late ValueChanged<String> onChanged;
  List<Friend>? listFriend = [];
  String isYour = '';

  @override
  void initState(){
    listFriend = List.from(widget.listFriend);
    super.initState();
  }

  String whoMessageLast({required String uib, required int index}){
    if(uib != widget.listFriend[index].uid){
      return 'Bạn: ';
    }else{
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild widget");
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: "Chats",
              color: Colors.white,
              fontSize: size.height * 0.022,
            ),
            SearchWidget(
              widthWidget: size.height * 0.2,
              text: query,
              hintText: 'Search NameUser',
              onChanged: searchBook,
            ),
          ],
        ),
        actions: [
          BlocBuilder<ChatsCubit, ChatsState>(
              buildWhen: (previous, current) => previous.isFriend != current.isFriend,
            builder: (context, state) {
              print("rebuild icon ${state.isFriend}");
              return IconButton(
                  onPressed: () {
                    context.read<ChatsCubit>().showAllPeopleOrShowFriend();
                  },
                  icon:  Icon(
                    state.isFriend?Icons.person:Icons.person_add_alt_1_rounded,
                    color: Colors.white,size: size.height * 0.035,
                  ));
            }
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<ChatsCubit>().yourOption();
                  },
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size:size.height * 0.03,
                  )),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  maxRadius: size.height * 0.01,
                  backgroundColor: Colors.red,
                  child: const SmallText(
                      text: "1",
                      color: Colors.white),
                ),
              )

            ],
          )
        ],
      ),
      body: ListFriend(listFriend: listFriend!),
    );
  }

  void searchBook(String query) {
    final listFriendSearch = widget.listFriend.where((user) {
      final nameLower = user.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      listFriend = listFriendSearch;
    });
  }


}


