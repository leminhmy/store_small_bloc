import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/cart_model.dart';
import 'package:store_small_bloc/models/order.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/orders/order_repository.dart';

import '../../../core/type/enum.dart';



part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AuthRepository _authRepository;
  final OrderRepository _orderRepository;
  CartCubit({required AuthRepository authRepository, required OrderRepository orderRepository})
      :_authRepository = authRepository,
        _orderRepository = orderRepository,
        super( const CartState());


  Future<void> loadingCart()async{
    _authRepository.user.listen((event) { });
    try{
      emit(state.copyWith(status: StatusType.loading));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: StatusType.loaded,listCart: demo_listcart));
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }
  Future<void> addCart(CartModel cartModel)async{
    emit(state.copyWith(rebuild: false));
    try{
      if(state.listCart.isEmpty){
        print("read 1");
        state.listCart.add(cartModel);
      }else if(state.listCart.any((element) => element.idProduct == cartModel.idProduct)){
        print("read 2");
        state.listCart[state.listCart.indexWhere((element) => element.idProduct == cartModel.idProduct)] = cartModel;
      }else{
        print("read 3");
        state.listCart.add(cartModel);
      }
      emit(state.copyWith(listCart: state.listCart,rebuild: true));

    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }
  void setQuantityIncreaseIndexCart(int index){
    try{
      state.listCart[index].quantity = state.listCart[index].quantity!+1;
      rebuildQuantity(index);
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
    // print(state.listCart[index].toJson());
  }
  void setQuantityReduceIndexCart(int index){
    try{
      if(state.listCart[index].quantity == 1){
        removeCartInList(index);
      }else{
        state.listCart[index].quantity = state.listCart[index].quantity!-1;
        rebuildQuantity(index);
      }
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }


  Future<void> removeCartInList(int index) async {
    emit(state.copyWith(listCart: state.listCart..removeAt(index)));
    rebuildListCart();
  }

  void rebuildListCart(){
    emit(state.copyWith(rebuild: false));
    emit(state.copyWith(rebuild: true));
  }
  void rebuildQuantity(int index){
    emit(state.copyWith(indexCart: index));
    emit(state.copyWith(indexCart: -1));
  }

  int getTotalPriceListCart(){
    int totalPrice = 0;
    for (var element in state.listCart) {
      totalPrice += (element.price! * element.quantity!);
    }
    return totalPrice;
  }

  void checkOutOrder(String address)async{
    emit(state.copyWith(messError: ""));
    if(_authRepository.getUser.isNotEmpty && address != "" && state.listCart.isNotEmpty){
      emit(state.copyWith(messError: "BeginOrder",status: StatusType.loading));
      await _orderRepository.addOrder(orderOption(address)).then((value) {
        if(value == "Success"){
          emit(state.copyWith(status: StatusType.loaded,listCart: [],messError: "Order Success"));
          rebuildListCart();
        }else{
          emit(state.copyWith(status: StatusType.error,messError: value));
        }
      });
    }else if(_authRepository.getUser.isEmpty){
      emit(state.copyWith(messError: "NoAccount",status: StatusType.init),);
    }
    else if(state.listCart.isEmpty){
      emit(state.copyWith(messError: "Order is Empty",status: StatusType.init),);
    }
    else if(address.isEmpty){
      emit(state.copyWith(messError: "Address is Empty",status: StatusType.init),);
    }
  }



  Order orderOption(String address) => Order(
    status: 1,
    userId: _authRepository.getUser.id,
    phone: _authRepository.getUser.phone,
    address: address,
    orderAmount: getTotalPriceListCart(),
    createdAt: DateTime.now().toString(),
    updatedAt: DateTime.now().toString(),
    orderItems: state.listCart,
  );

}
