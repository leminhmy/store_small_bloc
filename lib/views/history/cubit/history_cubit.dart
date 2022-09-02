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
  final AuthRepository _authRepository;
  HistoryCubit({required AuthRepository authRepository,required OrderRepository orderRepository}) :
        _orderRepository = orderRepository,
        _authRepository = authRepository,
        super(const HistoryState(listOrder: [],));


  void loadingHistory(){
    _authRepository.user.listen((event) {
      event.then((value) {
        if(value == ""){
          emit(state.copyWith(status: StatusType.init,listOrder: []));
        }else{
          if(_authRepository.getUser.status == 2){
            emit(state.copyWith(checkAdmin: true));
            getOrderAdmin();
          }else{
            emit(state.copyWith(checkAdmin: false));
            getOrderUser();
          }

        }
      });
    });

  }

  void getOrderUser(){
    _orderRepository.getOrderUser(_authRepository.getUser.id).listen((event) {
      emit(state.copyWith(status: StatusType.loaded,listOrder: event));
      rebuild();
    });
  }

  void getOrderAdmin(){
    _orderRepository.getOrderAdmin().listen((event) {
      emit(state.copyWith(status: StatusType.loaded,listOrder: event));
      rebuild();
    });
  }




  void rebuild(){
    emit(state.copyWith(rebuild: false));
    emit(state.copyWith(rebuild: true));
  }

}
