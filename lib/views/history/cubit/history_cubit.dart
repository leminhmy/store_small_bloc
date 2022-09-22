import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';

import '../../../models/order.dart';
import '../../../repositories/orders/order_repository.dart';


part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final OrderRepository _orderRepository;
  HistoryCubit({required OrderRepository orderRepository}) :
        _orderRepository = orderRepository,
        super(const HistoryState(listOrder: [],));




  void loadingHistory(){
    if(AuthRepository.currentUser.isNotEmpty){
      int? statusUser = AuthRepository.currentUser.status;
      if(statusUser == 2){
        emit(state.copyWith(checkAdmin: true,status: StatusType.loaded));
        getOrderAdmin();
      }
      else{
        emit(state.copyWith(checkAdmin: false,status: StatusType.loaded));
        getOrderUser();
      }
    }else{
      emit(state.copyWith(status: StatusType.init,listOrder: [],));
    }



  }


   getOrderUser(){
     _orderRepository.getOrderUser(AuthRepository.currentUser.id).listen((event) {
      emit(state.copyWith(status: StatusType.loaded,listOrder: event));
      rebuild();
    });
  }

   getOrderAdmin(){
     _orderRepository.getOrderAdmin().listen((event) {
      emit(state.copyWith(status: StatusType.loaded,listOrder: event));
      rebuild();
    });
  }

  void testListOrder(){
    print(state.listOrder.map((e) => e.toJson()).toList());
  }



  void rebuild(){
    emit(state.copyWith(rebuild: false));
    emit(state.copyWith(rebuild: true));
  }

}
