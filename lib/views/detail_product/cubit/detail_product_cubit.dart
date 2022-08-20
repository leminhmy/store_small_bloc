import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/cart_model.dart';
import 'package:store_small_bloc/models/order.dart';

import '../../../models/product.dart';

part 'detail_product_state.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  DetailProductCubit({required this.productsModel})
      : super(DetailProductState(productsModel: productsModel));

  final ProductsModel productsModel;

  Future<void> detailLoading() async {
    List<CartModel> listCart = demo_order[0].orderItems!;
    try {
      CartModel cartModel = CartModel();
      emit(state.copyWith(status: StatusType.loading));
      if (listCart.any((element) {
        if(element.idProduct == productsModel.id)
          {
            cartModel = element;
            return true;
          }
        else{
          return false;
        }
      })) {
        emit(state.copyWith(idCart: cartModel.id,productsModel: productsModel,status: StatusType.loaded, color:cartModel.color,size: cartModel.size,current: cartModel.quantity));
      } else {
        emit(state.copyWith(
            productsModel: productsModel,
            status: StatusType.loaded,
            color: productsModel.listColor![0],
            size: productsModel.listSize![0],
            current: 1,
        ));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  void changeCurrentIncrease() => emit(state.copyWith(current: (state.current+1)));
  void changeCurrentReduce() => emit(state.copyWith(current: (state.current-1)));
  void changeSize(int size) => emit(state.copyWith(size: size));
  void changeColor(String color) => emit(state.copyWith(color: color));

  CartModel cartOption() => CartModel(
    id: state.idCart,
    color: state.color,
        size: state.size,
        idProduct: productsModel.id,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        img: productsModel.img,
        name: productsModel.name,
        quantity: state.current,
        price: productsModel.price,
      );
}
