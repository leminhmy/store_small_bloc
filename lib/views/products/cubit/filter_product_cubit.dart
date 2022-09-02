import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/repositories/category/category_repository.dart';
import 'package:store_small_bloc/repositories/products/product_repository.dart';

import '../../../models/product.dart';
import '../../../models/shoes_type.dart';


part 'filter_product_state.dart';

class FilterProductCubit extends Cubit<FilterProductState> {
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;
  StreamSubscription? _categorySubscription;
  FilterProductCubit({required CategoryRepository categoryRepository,required ProductRepository productRepository})
      : _categoryRepository = categoryRepository, _productRepository = productRepository,
        super(const FilterProductState());

  List<ProductsModel> listProduct = [];


  Future<void> loadingProducts()async{
    try{
      emit(state.copyWith(status: StatusType.loading));
      await Future<void>.delayed(const Duration(seconds: 1));
      await getAllShoesType();
      await Future<void>.delayed(const Duration(seconds: 1));
      getAllProduct();
    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> filterProducts(int indexFilter)async{

    try{
      if(indexFilter ==0){
        emit(state.copyWith(status: StatusType.loading,));
        await Future<void>.delayed(const Duration(seconds: 2));
        getAllProduct();
      }else{
        emit(state.copyWith(status: StatusType.loading,));
        await Future<void>.delayed(const Duration(seconds: 2));
        List<ProductsModel> filterListProduct = [];
        for (var element in listProduct) {
          if(element.category == (state.listShoesType[indexFilter-1].name)){
            filterListProduct.add(element);
          }
        }
        emit(state.copyWith(status: StatusType.loaded,listProduct: filterListProduct,));
      }

    }catch(error){
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> getAllShoesType() async {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllShoesType().listen((event) {
      print('call shoesType');
      emit(state.copyWith(listShoesType: event));
    });
  }
  Future<void> getAllProduct() async {
   await _productRepository.getAllProducts().then((value) {
     emit(state.copyWith(status: StatusType.loaded,listProduct: value));
     listProduct = value;
   });
  }

}
