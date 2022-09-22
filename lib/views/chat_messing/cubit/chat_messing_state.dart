part of 'chat_messing_cubit.dart';

class ChatMessingState extends Equatable{
  final bool rebuild;
  final List<MessagesModel> listMessage;
  final XFile? imgSelected;
  final bool rebuildImgSelected;
  final Friend friend;
  final String uibUser;
  final int statusSendMess;
  const ChatMessingState({this.statusSendMess = -1,this.uibUser = "",required this.friend,this.rebuildImgSelected = false,this.imgSelected,this.rebuild = false, this.listMessage  = const []});

  @override
  // TODO: implement props
  List<Object?> get props => [statusSendMess,uibUser,friend,rebuildImgSelected,imgSelected,rebuild, listMessage];

  ChatMessingState copyWith({int? statusSendMess,String? uibUser,Friend? friend,bool? rebuildImgSelected,XFile? imgSelected,bool? rebuild, List<MessagesModel>? listMessage}){
    return ChatMessingState(
        rebuild:rebuild??this.rebuild,
      listMessage:listMessage??this.listMessage,
      imgSelected:imgSelected??this.imgSelected,
      rebuildImgSelected:rebuildImgSelected??this.rebuildImgSelected,
      friend:friend??this.friend,
      uibUser:uibUser??this.uibUser,
      statusSendMess:statusSendMess??this.statusSendMess,
    );
  }
}