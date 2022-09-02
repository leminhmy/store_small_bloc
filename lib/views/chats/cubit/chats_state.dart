part of 'chats_cubit.dart';

class ChatsState extends Equatable{
  final List<Friend> listFriend;
  final List<Friend> listPeople;
  final StatusType status;
  final bool rebuild;
  final int rebuildIndexList;
  final bool isFriend;
  const ChatsState({this.rebuildIndexList = -1,this.listPeople = const [],this.isFriend = false,this.rebuild = false,this.listFriend = const [], this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [rebuildIndexList,listPeople,isFriend,listFriend,status,rebuild];

  ChatsState copyWith({int? rebuildIndexList,List<Friend>? listPeople,bool? isFriend,List<Friend>? listFriend, StatusType? status, bool? rebuild}){
    return ChatsState(
      status: status??this.status,
      listFriend: listFriend??this.listFriend,
      rebuild: rebuild??this.rebuild,
      isFriend: isFriend??this.isFriend,
      listPeople: listPeople??this.listPeople,
      rebuildIndexList: rebuildIndexList??this.rebuildIndexList,

    );
  }
}