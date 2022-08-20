part of 'history_cubit.dart';

class HistoryState extends Equatable{
  final List<Order> listOrder;
  const HistoryState({required this.listOrder});

  @override
  // TODO: implement props
  List<Object?> get props => [listOrder];

}