part of 'chat_messing_cubit.dart';

class ChatMessingState extends Equatable{
  final int currentIndex;
  final List<MessagesModel> listMess;
  const ChatMessingState( {this.currentIndex = 0,required this.listMess,});

  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex,listMess];

}