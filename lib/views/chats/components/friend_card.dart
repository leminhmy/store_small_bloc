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
  const FriendCard({Key? key, required this.friend, required this.index, required this.routerCard}) : super(key: key);

  final Friend friend;
  final int index;
  final String routerCard;

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
                    routerCard != "people"?StreamBuilder(
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

                        }):const SizedBox(),
                  ],
                ),
                routerCard != "people"?StreamBuilder(
                    stream: context
                        .read<ChatsCubit>()
                        .getLastMessageFriend(uidFriend: friend.uid ?? ""),
                    builder: (context, AsyncSnapshot<MessagesModel> snapshot) {
                      String sender = "";
                      if(snapshot.data?.idSend == context.read<ChatsCubit>().yourOption().uid){
                        sender  = "Bạn: ";
                      }else{
                        sender = "";
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: "$sender${snapshot.data?.messaging ?? ""}",
                            color: Colors.black,
                          ),
                          BigText(
                            text: AppVariable.timeAgoFormat(
                                snapshot.data?.createdAt ?? ""),
                            color: Colors.black,
                          ),
                        ],
                      );
                    }):const SizedBox(),

              ],
            ),
          ),
          SizedBox(
            width: size.height * 0.01,
          ),
          ElevatedButton(
            onPressed: (){
              if(friend.statusFriend == 1){
                ShowDialogWidget.openDialogConfirm(context: context, size: size, mess: "UnFriend ${friend.name}",
                    changeConfirm: (){
                      context.read<ChatsCubit>().unFriend(friend, index,routerCard);
                    });
              }else if( friend.statusFriend == 0){
                ShowDialogWidget.openDialogConfirm(context: context, size: size, mess: "Cancel Friend ${friend.name}",
                    changeConfirm: (){
                      context.read<ChatsCubit>().unFriend(friend, index,routerCard);
                    });

              }else if(friend.statusFriend == 2){
                context.read<ChatsCubit>().acceptFriend(index);
              }else{
                context.read<ChatsCubit>().addFriend(friend, index,routerCard);
              }
            },
            child: BlocBuilder<ChatsCubit, ChatsState>(
                buildWhen: (previous, current) => previous.isFriend != current.isFriend,
              builder: (context, state) {
                switch (state.isFriend) {
                  case false:
                    if(routerCard == 'notFriend'){
                      return BlocBuilder<ChatsCubit, ChatsState> (
                          buildWhen: (previous, current) => current.rebuildIndexListNotFriend == index,
                          builder: (context, state) {
                            int statusNotFriend = state.listNotFriend[index].statusFriend??-1;
                            print("rebuild index card");
                            return BigText(
                              text: statusNotFriend == 2?"Chấp Nhận":statusNotFriend == 0?"Đã gửi":"Kết bạn",

                              color: Colors.white,);
                          }
                      );
                    }else{
                      return BlocBuilder<ChatsCubit, ChatsState> (
                          buildWhen: (previous, current) => current.rebuildIndexListFriend == index,
                          builder: (context, state) {
                            int statusNotFriend = state.listFriend[index].statusFriend??-1;
                            print("rebuild index card");
                            return BigText(
                              text: statusNotFriend == 1?"Bỏ Bạn":statusNotFriend == 0?"Đã gửi":statusNotFriend == 2?"Chấp nhận":"Kết bạn",
                              color: Colors.white,);
                          }
                      );
                    }

                  case true:
                    return BlocBuilder<ChatsCubit, ChatsState>(
                        buildWhen: (previous, current) => current.rebuildIndexListPeople == index,
                      builder: (context, state) {
                          print("rebuild index people $index");
                          int statusFriend = state.listPeople[index].statusFriend??-1;
                        return BigText(
                          text: statusFriend == 0?"Đã gửi":"Kết bạn",
                          color: Colors.white,);
                      }
                    );
                  default:
                    return const SizedBox();
                }

              }
            ),
          ),

        ],
      ),
    );
  }
}
