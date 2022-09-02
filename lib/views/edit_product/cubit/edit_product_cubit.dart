import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/product.dart';

import '../../../models/order.dart';
import '../../../repositories/products/product_repository.dart';


part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  final ProductsModel products;
  final ProductRepository _productRepository;
  EditProductCubit({required this.products,required ProductRepository productRepository})
       : _productRepository = productRepository,
        super(EditProductState(product: products));


  void onTapEvent(){
    bool change = !state.onTapEvent;
    emit(state.copyWith(onTapEvent: change));
  }

  void editImageProduct({required List<String> listImgUrl,required List<XFile> newListImgXFile}) async
  {
    emit(state.copyWith(status: StatusType.loading,messError: ""));
    List<String> listImgUrlUpload = [];
    List<String> listError = [];
    if(newListImgXFile.isNotEmpty){
      listImgUrlUpload = await _productRepository.uploadMultiFileImg(newListImgXFile, state.product.id!);
      for(int i = 0; i < listImgUrlUpload.length; i++){
        if(listImgUrlUpload[i].contains("Error")){
          listError.add("Image $i: Error");
          listImgUrlUpload.removeAt(i);
        }
      }
    }

    //emit mess upload image to store
    if(listError.isEmpty){
      emit(state.copyWith(status: StatusType.loaded,messError: "UpLoad Image Success"));
    }else{
      emit(state.copyWith(status: StatusType.error,messError: listError.toString()));
    }
    //emit set listimg url product
    List<String> listImgAllUrl = List.from(listImgUrl + listImgUrlUpload);
    if(listImgAllUrl != state.product.listImg){
      print("Start set listUrl");
      String messError = await _productRepository.setListImgProduct(state.product.id!, listImgAllUrl);
      emit(state.copyWith(messError: messError,status: StatusType.loaded));
    }
  }

  void updateProduct(ProductsModel product) async{
    emit(state.copyWith(status: StatusType.loading,messError: ""));
    Map<String, dynamic> jsonProduct = product.toJson();
    jsonProduct.removeWhere((key, value) => value == null || key == 'listImg');
    String messError = await _productRepository.updateProduct(jsonProduct: jsonProduct);
    if(messError == "Success"){
      emit(state.copyWith(status: StatusType.loaded,messError: messError));
    }else{
      emit(state.copyWith(status: StatusType.error,messError: messError));
    }
  }

}
