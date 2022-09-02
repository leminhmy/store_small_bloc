import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';

import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/chat/chat_repository.dart';


part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;
  ChatsCubit({required AuthRepository authRepository,required ChatRepository chatRepository}) :
        _chatRepository=chatRepository,
        _authRepository=authRepository,
        super(const ChatsState());


  Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) { });
  int start = 5;
  List<Friend> listAddFriend = [];
  void startTimer(VoidCallback callFn) {
    start = 5;
    const oneSec = Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
            timer.cancel();
            callFn();
            print("Timer End");
        } else {
          start--;
         print("Timer Start: $start");
        }
      },
    );
  }

  void loading() {
    _authRepository.user.listen((event) {
     event.then((value) {
       if(value.isNotEmpty){
         emit(state.copyWith(status: StatusType.loading,listFriend: []));
         getAllFriend();
       }else{
         emit(state.copyWith(status: StatusType.init,listFriend: []));
       }
     });
    });
  }

  void showAllPeopleOrShowFriend()async{
    emit(state.copyWith(isFriend: !state.isFriend,status: StatusType.loading));
    await Future.delayed(const Duration(seconds: 1));
    if(state.isFriend){
      getAllPeople();

    }else{
      getAllFriend();

    }

  }

  void getAllPeople() async {

     _chatRepository.streamAllPeople().listen((event) {

      if(state.listFriend.isNotEmpty){
        for(int i = 0; i < state.listFriend.length; i++){
          print("start fn $i");
          event.removeWhere((element) => element.uid == state.listFriend[i].uid);
        }
        event.removeWhere((element) => element.uid == _authRepository.getUser.id);
        print("print end");
        emit(state.copyWith(listPeople: event,status: StatusType.loaded));
      }else{
        emit(state.copyWith(listPeople: event,status: StatusType.loaded));

      }

    });


  }

  void getAllFriend(){
    _chatRepository.getAllFriend(_authRepository.getUser.id).listen((event) {
      print("data change");
      emit(state.copyWith(status: StatusType.loaded,listFriend: event));

    });
  }

  void rebuild(){
    emit(state.copyWith(rebuild: true));
    emit(state.copyWith(rebuild: false));
  }

  Stream<MessagesModel> getLastMessageFriend({required String uidFriend}){
   return _chatRepository.streamLastMessageFriend(uidUser: _authRepository.getUser.id, uidFriend: uidFriend);
  }

  Stream<int> getLengthMissMessage({required String uidFriend}){
    return _chatRepository.streamLengthMissMessageFriend(uidUser: _authRepository.getUser.id, uidFriend: uidFriend);
  }
  void getAllMessage(){
    _chatRepository.streamMessageFriend(uidUser: _authRepository.getUser.id, uidFriend: "C9apogCJxxci0HwBSq1lhKHQt7j1").listen((event) {
      print(event.map((e) => e.toJson()).toList());
    });
  }

  void sendMessage()async{
    MessagesModel messages = MessagesModel(
      createdAt: DateTime.now().toString(),
      idSend: "3txhdLarh3MoYHZMdaPPjLMqt4k1",
      idTake: "C9apogCJxxci0HwBSq1lhKHQt7j1",
      messaging: "hello4",
      see: 0,
    );
    String status = await _chatRepository.sendMessage(messages);
    print(status);
  }


  void addFriend(Friend friend,int index){
    _timer.cancel();
      if(!state.isFriend){
      print("start set list friend");
      state.listFriend.elementAt(index).statusFriend = 0;
      emit(state.copyWith(listFriend:  state.listFriend));
    }else{
      print("start set list people");
      if(state.listPeople[index].statusFriend == 0){
        state.listPeople.elementAt(index).statusFriend = null;
        listAddFriend.remove(friend);
      }else{
        listAddFriend.add(friend);
        state.listPeople.elementAt(index).statusFriend = 0;
      }
      rebuildIndexList(index);
    }
    startTimer(() {
      if(listAddFriend.isNotEmpty){
        _chatRepository.addFriend(your: yourOption(), newListFriend: listAddFriend);

      }
    },);

  }

  rebuildIndexList(int index){
    emit(state.copyWith(rebuildIndexList: index));
    emit(state.copyWith(rebuildIndexList: -1));
  }

  Friend yourOption(){
    return Friend.fromJson(_authRepository.getUser.toJson());
  }
}
