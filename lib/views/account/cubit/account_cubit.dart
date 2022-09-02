import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';


part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AuthRepository _authRepository;
  AccountCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.getUser.isNotEmpty? AccountState(status: StatusType.loaded,yourUser: authRepository.getUser):AccountState(yourUser: UserModel.empty,status: StatusType.init));




  void loadingAccount() async{
    print("start loading account");
    _authRepository.user.listen((event) {
      print("account change from bloc");
      event.then((value) {
        if(value != ""){
          emit(state.copyWith(status: StatusType.loading,errorMessage: ""));
          emit(state.copyWith(yourUser: _authRepository.getUser,status: StatusType.loaded,errorMessage: ""));
        }else{
          emit(state.copyWith(yourUser: _authRepository.getUser,status: StatusType.init,errorMessage: ""));

        }
      });

    });
  }



  UserModel getUidUser(){
    return _authRepository.getUser;
  }


  void logoutRequested() async{
    await Future<void>.delayed(const Duration(seconds: 2));
    unawaited(_authRepository.logOut());
    emit(state.copyWith(status: StatusType.init,yourUser: UserModel.empty,errorMessage: ""));
  }
  void updateAccount({required String name, required String phone, XFile? image}) async{
    emit(state.copyWith(errorMessage: ""));
    if(name.isEmpty){
      emit(state.copyWith(errorMessage: "Name is Empty"));
    }else if(phone.isEmpty){
      emit(state.copyWith(errorMessage: "Phone is Empty"));
    }else{
      emit(state.copyWith(errorMessage: "Updating",status: StatusType.loading));
      String? urlImageInfo;
      if(image != null){
        urlImageInfo = await _authRepository.uploadImageUser(image);
      }
      if(urlImageInfo == "Error"){
        emit(state.copyWith(errorMessage: "Image error"));
      }else{
        Map<String, dynamic> updateProfileInfo = {"name":name,"phone":int.parse(phone),"image":urlImageInfo};
        String statusUpdateInfo = await _authRepository.updateAccount(updateProfileInfo);
        if(statusUpdateInfo == "Success"){
          emit(state.copyWith(errorMessage: statusUpdateInfo,status: StatusType.loaded));
          await Future<void>.delayed(const Duration(seconds: 2));
          loadingAccount();
        }else{
          emit(state.copyWith(errorMessage: "Error update profile"));
        }
      }
    }
  }

  Future<String> updateLocationUser(String location) async{
    Map<String, dynamic> updateProfileInfo = {"address":location,};
    String statusUpdateInfo = await _authRepository.updateAccount(updateProfileInfo);
    if(statusUpdateInfo == "Success"){
      loadingAccount();
      return "Success";
    }else{
      return "Fail update Address";
    }
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}