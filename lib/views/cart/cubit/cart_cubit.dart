import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:store_small_bloc/models/cart_model.dart';
import 'package:store_small_bloc/models/order.dart';
import 'package:store_small_bloc/models/product.dart';

import '../../../core/type/enum.dart';


part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super( CartState(listCart: demo_order[0].orderItems!));

  Future<void> loadingCart()async{
    try{
      emit(state.copyWith(status: StatusType.loading));
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: StatusType.loaded,listCart: state.listCart));
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }
  Future<List<CartModel>> addCart(CartModel cartModel)async{
    try{
      if(state.listCart.any((element) => element.id == cartModel.id)){
        state.listCart[state.listCart.indexWhere((element) => element.idProduct == cartModel.idProduct)] = cartModel;
      }else{
        state.listCart.add(cartModel);
      }
      emit(state.copyWith(status: StatusType.loaded,listCart: state.listCart));
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
    return state.listCart;
  }
  void setQuantityIncreaseIndexCart(int index){
    try{
      state.listCart[index].quantity = state.listCart[index].quantity!+1;
      emit(state.copyWith(indexCart: index));
      emit(state.copyWith(indexCart: -1));
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
    // print(state.listCart[index].toJson());
  }
  void setQuantityReduceIndexCart(int index){
    try{
      state.listCart[index].quantity = state.listCart[index].quantity!-1;
      emit(state.copyWith(indexCart: index));
      emit(state.copyWith(indexCart: -1));
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

}
