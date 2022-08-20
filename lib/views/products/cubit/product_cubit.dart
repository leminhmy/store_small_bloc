import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_small_bloc/core/type/enum.dart';

import '../../../models/product.dart';
import '../../../repositories/products/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductState());

  Future<void> loadingProducts() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      await Future<void>.delayed(const Duration(seconds: 2));
      final listProductBanner = demo_products;
      emit(state.copyWith(
        status: StatusType.loaded,
        listProductBanner: listProductBanner,
      ));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> mapLoadProductState() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      await Future<void>.delayed(const Duration(seconds: 2));
      _productSubscription?.cancel();
      _productSubscription =
          _productRepository.getAllProducts().listen((event) {
            // print("call from Stream");
        return emit(state.copyWith(
          status: StatusType.loaded,
          listProductBanner: event,
        ));
      });
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }
}
