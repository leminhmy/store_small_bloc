import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:store_small_bloc/app/utils/app_variable.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';

import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/chat/chat_repository.dart';


part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatRepository _chatRepository;
  ChatsCubit({required ChatRepository chatRepository}) :
        _chatRepository=chatRepository,
        super(const ChatsState());


  Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) { });
  int start = 5;
  List<Friend> listAddFriend = [];
  List<Friend> listUnFriend = [];
  List<Friend> listAcceptFriend = [];
  List<Friend> listPeople = [];
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

  void clearCache(){
    listAddFriend = [];
    listUnFriend = [];
    listAcceptFriend = [];
  }

   runFnUnOrAddFriend(){

    return startTimer(() {

      print(listAddFriend.map((e) => e.toJson()).toList());
      print("tren list addfriend");
      print(listUnFriend.map((e) => e.toJson()).toList());
     print("start timer");
      if(listAddFriend.isNotEmpty){
        print("listAddFriend is not empty");
        _chatRepository.addFriend(your: yourOption(), newListFriend: listAddFriend);
        listAddFriend = [];
      }
      if(listUnFriend.isNotEmpty){
        print("listUnFriend is not empty");
        _chatRepository.unFriend(your: yourOption(), newListFriend: listUnFriend);

        listUnFriend = [];

      }
      if(listAcceptFriend.isNotEmpty){
        print("listUnFriend is not empty");
        _chatRepository.acceptFriend(your: yourOption(), newListFriend: listAcceptFriend);

        listAcceptFriend = [];
      }
    });
  }

  void loading() {
    if(AuthRepository.currentUser.isNotEmpty){
      emit(state.copyWith(status: StatusType.loading,listFriend: []));
      getAllFriend();
      getNotAllFriend();
      getAllPeople();
    }else{
      emit(state.copyWith(status: StatusType.init,listFriend: []));

    }

  }

  void getNotAllFriend(){
    _chatRepository.getAllInviteFriend(AuthRepository.currentUser.id).listen((event) {
      print("data change");
      emit(state.copyWith(status: StatusType.loaded,listNotFriend: event));
      rebuildListNotFriend();
    });
  }

   filterListPeopleOrFriend(){
    print("start fillter");
     emit(state.copyWith(filterFriend: true));
     emit(state.copyWith(filterFriend: false));
  }

  void showAllPeopleOrShowFriend()async{
    if(state.isFriend == false){
      rebuildListPeople();
    }
    emit(state.copyWith(isFriend: !state.isFriend));
  }

   getAllPeople()  {
    return _chatRepository.streamAllPeople().listen((event) {

       event.removeWhere((element) {
         if(element.uid == AuthRepository.currentUser.id){
           print("remove element ${element.toJson()}");
           return true;
         }else{
           print("ko co remove");
           return false;
         }
       });
       listPeople = List.from(event);
    });
  }

  void getAllFriend(){
    _chatRepository.getAllFriend(AuthRepository.currentUser.id).listen((event) {
      print("get all friend");
      for (var element in event) {
        if(element.updatedAt == null || AppVariable.timeAgoOneDay(element.updatedAt!)){
          print("update friend");
          ChatRepository().updateInfoFriend(uidFriend: element.uid!,statusFriend: 1);
        }
      }
      print("data change");
      emit(state.copyWith(status: StatusType.loaded,listFriend: event));
      rebuildListFriend();

    });
  }

  void rebuild(){
    emit(state.copyWith(rebuild: true));
    emit(state.copyWith(rebuild: false));
  }

  void rebuildListNotFriend(){
    emit(state.copyWith(rebuildListNotFriend: true));
    emit(state.copyWith(rebuildListNotFriend: false));
  }
  void rebuildListFriend(){
    emit(state.copyWith(rebuildListFriend: true));
    emit(state.copyWith(rebuildListFriend: false));
  }
  void rebuildListPeople(){
    List<Friend> listPeopleFilter = List.from(listPeople);
    List<Friend> filterList = List.from(state.listFriend + state.listNotFriend);
    if(filterList.isNotEmpty){
      for(int i = 0; i < filterList.length; i++){
        listPeopleFilter.removeWhere((element) => element.uid == filterList[i].uid);
      }
      emit(state.copyWith(listPeople: listPeopleFilter,status: StatusType.loaded));
    }else{
      emit(state.copyWith(listPeople: listPeopleFilter,status: StatusType.loaded));
    }
  }

  Stream<MessagesModel> getLastMessageFriend({required String uidFriend}){
   return _chatRepository.streamLastMessageFriend(uidUser: AuthRepository.currentUser.id, uidFriend: uidFriend);
  }

  Stream<int> getLengthMissMessage({required String uidFriend}){
    return _chatRepository.streamLengthMissMessageFriend(uidUser: AuthRepository.currentUser.id, uidFriend: uidFriend);
  }
  void getAllMessage(){
    _chatRepository.streamMessageFriend(uidUser: AuthRepository.currentUser.id, uidFriend: "C9apogCJxxci0HwBSq1lhKHQt7j1").listen((event) {
      print(event.map((e) => e.toJson()).toList());
    });
  }






  rebuildIndexListPeople({required Friend friend, required int index,required int setStatus}){
    state.listPeople.elementAt(index).statusFriend = setStatus;
    emit(state.copyWith(rebuildIndexListPeople: index));
    emit(state.copyWith(rebuildIndexListPeople: -1));
  }
  rebuildIndexListFriend({required Friend friend, required int index,required int setStatus}){
    state.listFriend.elementAt(index).statusFriend = setStatus;
    emit(state.copyWith(rebuildIndexListFriend: index));
    emit(state.copyWith(rebuildIndexListFriend: -1));
  }
  rebuildIndexListNotFriend({required Friend friend, required int index,required int setStatus}){
    state.listNotFriend.elementAt(index).statusFriend = setStatus;
    emit(state.copyWith(rebuildIndexListNotFriend: index));
    emit(state.copyWith(rebuildIndexListNotFriend: -1));
  }
  void addFriend(Friend friend,int index, String routeCard){
    _timer.cancel();
    if(routeCard == 'friend'){
      rebuildIndexListFriend(friend: friend,index: index,setStatus: 0);
    }else if(routeCard == 'notFriend'){
      rebuildIndexListNotFriend(friend: friend,index: index,setStatus: 0);

    }else if(routeCard == 'people'){
      rebuildIndexListPeople(friend: friend,index: index,setStatus: 0);
    }
    if(listUnFriend.isNotEmpty && listUnFriend.every((element) => element.uid == friend.uid)){
      listUnFriend.removeWhere((element) => element.uid == friend.uid);
    }else{
      listAddFriend.add(friend);

    }
    runFnUnOrAddFriend();

  }

  void acceptFriend(int index){
    listAcceptFriend.add(state.listNotFriend[index]);
    state.listNotFriend.removeAt(index);
    rebuildListNotFriend();
    runFnUnOrAddFriend();
  }
  void unFriend(Friend friend,int index,String routeCard){
    _timer.cancel();
    if(routeCard == 'friend'){
      state.listFriend.removeWhere((element) => element.uid == friend.uid);
      rebuildListFriend();
    }else if(routeCard == 'notFriend'){
      rebuildIndexListNotFriend(friend: friend,index: index,setStatus: -1);

    }else if(routeCard == 'people'){
      rebuildIndexListPeople(friend: friend,index: index,setStatus: -1);
    }
    if(listAddFriend.isNotEmpty && listAddFriend.every((element) => element.uid == friend.uid)){
      print("true ko");
      listAddFriend.removeWhere((element) => element.uid == friend.uid);
    }else{
      print("false ko");
      listUnFriend.add(friend);

    }
    runFnUnOrAddFriend();

  }





  Friend yourOption(){
    Friend yourCard = Friend.fromJson(AuthRepository.currentUser.toJson());
    return yourCard;
  }
}
