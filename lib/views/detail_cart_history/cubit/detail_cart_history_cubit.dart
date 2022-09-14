
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/orders/order_repository.dart';

import '../../../models/order.dart';


part 'detail_cart_hisotry_state.dart';

class DetailCartHistoryCubit extends Cubit<DetailCartHistoryState> {
  final OrderRepository? _orderRepository;
  final Order order;
  DetailCartHistoryCubit({required this.order, OrderRepository? orderRepository})
      : _orderRepository = orderRepository,
        super(DetailCartHistoryState(order: order));



  void updateStatus(int status, String message)async{
    emit(state.copyWith(status: StatusType.loading,errorMessage: "Updating"));
    Order newOrder = Order(id: state.order.id,userId: state.order.userId,message: message,status: status,updatedAt: DateTime.now().toString());
    String statusUpdate = await _orderRepository!.updateOrder(newOrder);
    if(statusUpdate != ""){
      emit(state.copyWith(status: StatusType.error,errorMessage: statusUpdate));
    }else{
      emit(state.copyWith(status: StatusType.loaded,errorMessage: "Update Success"));
    }
  }



}

