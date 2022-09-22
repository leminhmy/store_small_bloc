part of 'chats_cubit.dart';

class ChatsState extends Equatable{
  final List<Friend> listFriend;
  final List<Friend> listPeople;
  final List<Friend> listNotFriend;
  final StatusType status;
  final bool rebuild;
  final int rebuildIndexListPeople;
  final int rebuildIndexListNotFriend;
  final int rebuildIndexListFriend;
  final bool isFriend;
  final bool rebuildListNotFriend;
  final bool rebuildListFriend;
  final bool rebuildListPeople;
  final bool filterFriend;
  const ChatsState({this.filterFriend = false,this.rebuildListPeople = false,this.rebuildListFriend = false,this.rebuildIndexListFriend = -1,this.rebuildIndexListNotFriend = -1,this.rebuildListNotFriend = false,this.listNotFriend = const [],this.rebuildIndexListPeople = -1,this.listPeople = const [],this.isFriend = false,this.rebuild = false,this.listFriend = const [], this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [filterFriend,rebuildListPeople,rebuildListFriend,rebuildIndexListFriend,rebuildIndexListNotFriend,rebuildListNotFriend,listNotFriend,rebuildIndexListPeople,listPeople,isFriend,listFriend,status,rebuild];

  ChatsState copyWith({bool? filterFriend,bool? rebuildListPeople,bool? rebuildListFriend,int? rebuildIndexListFriend,int? rebuildIndexListNotFriend,bool? rebuildListNotFriend,List<Friend>? listNotFriend,int? rebuildIndexListPeople,List<Friend>? listPeople,bool? isFriend,List<Friend>? listFriend, StatusType? status, bool? rebuild}){
    return ChatsState(
      status: status??this.status,
      listFriend: listFriend??this.listFriend,
      rebuild: rebuild??this.rebuild,
      isFriend: isFriend??this.isFriend,
      listPeople: listPeople??this.listPeople,
      listNotFriend: listNotFriend??this.listNotFriend,
      rebuildListNotFriend: rebuildListNotFriend??this.rebuildListNotFriend,
      rebuildIndexListFriend: rebuildIndexListFriend??this.rebuildIndexListFriend,
      rebuildIndexListNotFriend: rebuildIndexListNotFriend??this.rebuildIndexListNotFriend,
      rebuildIndexListPeople: rebuildIndexListPeople??this.rebuildIndexListPeople,
      rebuildListFriend: rebuildListFriend??this.rebuildListFriend,
      rebuildListPeople: rebuildListPeople??this.rebuildListPeople,
      filterFriend: filterFriend??this.filterFriend,

    );
  }
}