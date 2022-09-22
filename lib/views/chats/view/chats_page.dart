import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_small_bloc/app/utils/app_variable.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/chats/components/list_people.dart';
import 'package:store_small_bloc/views/notification/notification.dart';

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
  const ChatsPage({
    Key? key,
    required this.listFriend,
  }) : super(key: key);

  final List<Friend> listFriend;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String query = '';
  late ValueChanged<String> onChanged;
  List<Friend> listFriend = [];
  List<Friend> listFilter = [];
  String isYour = '';

  String whoMessageLast({required String uib, required int index}) {
    if (uib != listFriend[index].uid) {
      return 'Bạn: ';
    } else {
      return '';
    }
  }

  @override
  void initState() {
    listFriend = widget.listFriend;
    listFilter = widget.listFriend;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(" check key board ${MediaQuery.of(context).viewInsets.bottom}");
    print("rebuild widget");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                buildWhen: (previous, current) =>
                    previous.isFriend != current.isFriend,
                builder: (context, state) {
                  print("rebuild icon ${state.isFriend}");

                  return IconButton(
                      onPressed: () {
                        if (!state.isFriend) {
                          print("people");

                          listFriend = List.from(state.listPeople);
                          listFilter = List.from(state.listPeople);
                        } else {
                          listFriend = List.from(state.listFriend);
                          listFilter = List.from(state.listFriend);

                          print("friend");
                        }
                        context.read<ChatsCubit>().showAllPeopleOrShowFriend();
                      },
                      icon: Icon(
                        state.isFriend
                            ? Icons.person
                            : Icons.person_add_alt_1_rounded,
                        color: Colors.white,
                        size: size.height * 0.035,
                      ));
                }),
            BlocBuilder<NotificationCubit, NotificationState>(
                buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                  print("rebuild icon notification");
                  int lengthNotiNotSee = 0;
                if(state.listNotification.any((element) => element.status == "0")){
                  lengthNotiNotSee++;
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, RouteName.notification,
                            arguments: ""),
                        icon: Icon(
                          lengthNotiNotSee>0?Icons.notifications_active:Icons.notifications_rounded,
                          color: Colors.white,
                          size: size.height * 0.03,
                        )),
                    lengthNotiNotSee>0?Positioned(
                      right: 5,
                      top: 5,
                      child: CircleAvatar(
                        maxRadius: size.height * 0.01,
                        backgroundColor: Colors.red,
                        child: SmallText(text: "$lengthNotiNotSee", color: Colors.white),
                      ),
                    ): const Positioned(child: SizedBox())
                  ],
                );
              }
            )
          ],
        ),
        body:
            BlocBuilder<ChatsCubit, ChatsState>(buildWhen: (previous, current) {
          if (previous.isFriend != current.isFriend) {
            if (current.isFriend) {
              //people
              listFriend = List.from(current.listPeople);
              listFilter = List.from(current.listPeople);
            } else {
              listFriend = List.from(current.listFriend);
              listFilter = List.from(current.listFriend);
            }
            return true;
          } else if (previous.filterFriend != current.filterFriend) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          print("rebuild list friend or people");
          switch (state.isFriend) {
            case false:
              return ListFriend(listFriend: listFilter);
            case true:
              return ListPeople(listFriend: listFilter);
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }

  void searchBook(String query) {
    print("call filtter");
    final listFriendSearch = listFriend.where((user) {
      final nameLower = user.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();
    this.query = query;
    listFilter = List.from(listFriendSearch);
    print(listFilter.map((e) => e.toJson()).toList());
    print(listFriend.map((e) => e.toJson()).toList());
    context.read<ChatsCubit>().filterListPeopleOrFriend();
  }
}
