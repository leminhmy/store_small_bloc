import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/models/friend.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';

import '../../../repositories/chat/chat_repository.dart';

part 'chat_messing_state.dart';

class ChatMessingCubit extends Cubit<ChatMessingState> {
  final ChatRepository _chatRepository;
  final Friend modelFriend;


  ChatMessingCubit(
      {required this.modelFriend,
      required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(ChatMessingState(friend: modelFriend));


  late final StreamSubscription<List<MessagesModel>> streamMessage;

  void loadingUserModel(){
    emit(state.copyWith(uibUser: AuthRepository.currentUser.id));
    loadingStreamMessageFriend();
  }
  void disposeListenMessage(){
    streamMessage.cancel();
  }

  void updateStatusMessage(){
    _chatRepository.updateStatusMessage(listMessage: state.listMessage, uid: _getUidUser(), idFriend: modelFriend.uid??"");
  }

  void setStatusSend(int status){
    emit(state.copyWith(statusSendMess: status));
  }

  void loadingStreamMessageFriend() {
    streamMessage =  _chatRepository
        .streamMessageFriend(
            uidUser: _getUidUser(), uidFriend: modelFriend.uid!)
        .listen((event) {
          print("listten has data new");
      emit(state.copyWith(listMessage: event));
      rebuildListMessage();
    });
  }

  void rebuildListMessage() {
    emit(state.copyWith(rebuild: true));
    emit(state.copyWith(rebuild: false));
  }

  void rebuildImgSelected() {
    emit(state.copyWith(rebuildImgSelected: true));
    emit(state.copyWith(rebuildImgSelected: false));
  }

  void sendMessage(String content) async {
   if(state.statusSendMess == 0){
     return;
   }else{
      setStatusSend(0);
    String imgUrl = "";
    if (state.imgSelected?.path != null && state.imgSelected?.path != "") {
      String getUrlImg =
          await _chatRepository.uploadFile(image: state.imgSelected!, uidFriend: modelFriend.uid!, uid: _getUidUser());
      if (getUrlImg.contains("error")) {
        print("error upload img chat");
      } else {
        imgUrl = getUrlImg;
        removeImgSelected();
      }
    }
    if(content != "" || imgUrl != ""){
      MessagesModel messages = MessagesModel(
        createdAt: DateTime.now().toString(),
        idSend: _getUidUser(),
        image: imgUrl,
        idTake: modelFriend.uid,
        messaging: content,
        see: 0,
      );
      String status = await _chatRepository.sendMessage(messages);
      if(status == ""){
        setStatusSend(1);
      }else{
        setStatusSend(2);
      }
    }
   }



  }

  void selectedImg(XFile fileImg){
    emit(state.copyWith(imgSelected: fileImg));
    rebuildImgSelected();
  }

  void removeImgSelected(){
    print("tapded");
    XFile remove = XFile("");
    emit(state.copyWith(imgSelected: remove));
    rebuildImgSelected();
  }

  String _getUidUser() => AuthRepository.currentUser.id;
}
