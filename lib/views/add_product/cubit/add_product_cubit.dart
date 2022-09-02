import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/core/type/enum.dart';

import '../../../models/product.dart';
import '../../../repositories/products/product_repository.dart';


part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductRepository _productRepository;
  AddProductCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const AddProductState());


  Future<void> addProductNew(ProductsModel product, List<XFile> listImg)async {
    // await Future<void>.delayed(const Duration(seconds: 2));
    String checkInput =  await checkEmptyProduct(product,listImg);

    if(checkInput.isNotEmpty){
      emit(state.copyWith(messError: checkInput));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(messError: ""));
    }else{
      emit(state.copyWith(status: StatusType.loading));
      String errorMess = await _productRepository.addProduct(product,listImg);
      if(errorMess.isEmpty){
        emit(state.copyWith(messError: "UploadSuccess",status: StatusType.loaded));
      }else{
        emit(state.copyWith(messError: errorMess,status: StatusType.error));
      }
    }
  }



  Future<String> checkEmptyProduct(ProductsModel product,List<XFile>? listImg) async{
    if(product.name?.isEmpty??true){
      return "Name is Empty";
    }
    else if(product.subTitle?.isEmpty??true){
      return "SubTitle is Empty";
    }
    else if(product.price! < 0){
      return "Price is Empty";
    }
    else if(product.description?.isEmpty??true){
      return "Description is Empty";
    }
    else if(product.category?.isEmpty??true){
      return "Category is Empty";
    }
    else if(product.listColor?.isEmpty??true){
      return "ListColor is Empty";
    }
    else if(product.listSize?.isEmpty??true){
      return "ListSize is Empty";
    }
    else if(listImg?.isEmpty??true){
      return "ListImg is Empty";
    }else{
      return "";
    }
  }


}
