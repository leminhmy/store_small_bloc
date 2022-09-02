part of 'history_cubit.dart';

class HistoryState extends Equatable{
  final List<Order> listOrder;
  final StatusType status;
  final bool checkAdmin;
  final bool rebuild;
  const HistoryState({this.checkAdmin = false,required this.listOrder, this.status = StatusType.init,this.rebuild = false});

  @override
  // TODO: implement props
  List<Object?> get props => [listOrder, status,rebuild,checkAdmin];

  HistoryState copyWith({StatusType? status, List<Order>? listOrder,bool? rebuild,bool? checkAdmin}){
    return HistoryState(
      status: status??this.status,
      listOrder: listOrder??this.listOrder,
      rebuild: rebuild??this.rebuild,
      checkAdmin: checkAdmin??this.checkAdmin,
    );
  }

}