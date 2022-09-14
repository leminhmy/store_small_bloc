part of 'detail_cart_history_cubit.dart';


class DetailCartHistoryState extends Equatable{
  final StatusType status;
  final String errorMessage;
  final Order order;
  const DetailCartHistoryState({required this.order ,this.errorMessage = "", this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage, status];

  DetailCartHistoryState copyWith({StatusType? status, String? errorMessage, Order? order}){
    return DetailCartHistoryState(
      status: status??this.status,
      errorMessage: errorMessage??this.errorMessage,
      order: order??this.order,
    );
  }

}