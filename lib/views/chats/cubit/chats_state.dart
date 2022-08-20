part of 'chats_cubit.dart';

class ChatsState extends Equatable{
  final int currentIndex;
  const ChatsState({this.currentIndex = 0});

  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];

}