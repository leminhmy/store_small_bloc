import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';

import '../../../app/utils/app_variable.dart';
import '../../../models/friend.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({Key? key, required this.friend, required this.index}) : super(key: key);

  final Friend friend;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      child: Row(
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.15,
            alignment: const Alignment(1, 0.8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: friend.image == null || friend.image == ""
                    ? const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/no_image.png"),
                ):DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(friend.image!),
                      )

            ),
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 20,
                )
              ],
            ),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text: "${friend.name}",
                      color: Colors.black,
                    ),
                    StreamBuilder(
                        stream: context
                            .read<ChatsCubit>()
                            .getLengthMissMessage(uidFriend: friend.uid ?? ""),
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          if(snapshot.data != null && snapshot.data! > 0){
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(Icons.circle,color: Colors.red,),
                                SmallText(
                                  text: snapshot.data.toString(),
                                  color: Colors.white,
                                ),
                              ],
                            );
                          }else{
                            return const SizedBox();
                          }

                        }),
                  ],
                ),
                StreamBuilder(
                    stream: context
                        .read<ChatsCubit>()
                        .getLastMessageFriend(uidFriend: friend.uid ?? ""),
                    builder: (context, AsyncSnapshot<MessagesModel> snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: snapshot.data?.messaging ?? "",
                            color: Colors.black,
                          ),
                          BigText(
                            text: AppVariable.timeAgoFormat(
                                snapshot.data?.createdAt ?? ""),
                            color: Colors.black,
                          ),
                        ],
                      );
                    }),

              ],
            ),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          BlocBuilder<ChatsCubit, ChatsState>(
             buildWhen: (previous, current) => previous.isFriend != current.isFriend,
            builder: (context, state) {
              switch (state.isFriend) {
                case false:
                  return BlocBuilder<ChatsCubit, ChatsState>(
                      buildWhen: (previous, current) {
                        if(previous.listFriend[index].statusFriend != current.listFriend[index].statusFriend){
                          return true;
                        }else{
                          return false;
                        }
                      },
                      builder: (context, state) {
                        print("rebuild status friend");
                        int statusFriend = state.listFriend[index].statusFriend??-1;
                        return ElevatedButton(
                          onPressed: (){

                          },
                          child: BigText(
                            text: statusFriend == 1?"Bỏ Bạn":statusFriend == 0?"Đã gửi":"Kết bạn",
                            color: Colors.white,),
                        );
                      }
                  );
                case true:
                  return BlocBuilder<ChatsCubit, ChatsState>(
                      buildWhen: (previous, current) {
                        if(current.rebuildIndexList == index){
                          return true;
                        }else{
                          return false;
                        }
                      },
                      builder: (context, state) {
                        print("rebuild status index peolple");
                        int statusFriend = state.listPeople[index].statusFriend??-1;
                        return ElevatedButton(
                          onPressed: (){
                            print("taped add friend");
                            context.read<ChatsCubit>().addFriend(state.listPeople[index], index);
                          },
                          child: BigText(
                            text: statusFriend == 0?"Đã gửi":"Kết bạn",
                            color: Colors.white,),
                        );
                      }
                  );
                default:
                  return const SizedBox();
              }
            }
          ),

        ],
      ),
    );
  }
}
