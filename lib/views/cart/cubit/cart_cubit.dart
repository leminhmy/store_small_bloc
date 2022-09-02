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

  CartCubit() : super( const CartState());


  Future<void> loadingCart()async{
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
      emit(state.copyWith(indexCart: index));
      emit(state.copyWith(indexCart: -1));
      print("taped setQuantityIncreaseIndexCart");
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
    // print(state.listCart[index].toJson());
  }
  void setQuantityReduceIndexCart(int index){
    try{
      if(state.listCart[index].quantity == 1){
        emit(state.copyWith(indexCart: index,messError: "Delete product ${state.listCart[index].name}"));
        removeCartInList(index);
        emit(state.copyWith(messError: ""));
      }else{
        state.listCart[index].quantity = state.listCart[index].quantity!-1;
        emit(state.copyWith(indexCart: index));
        emit(state.copyWith(indexCart: -1));
      }
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }


  Future<void> removeCartInList(int index) async {
    print("start removeCartInList");
    emit(state.copyWith(rebuild: false));
    emit(state.copyWith(rebuild: true,listCart: state.listCart..removeAt(index)));
  }

}
