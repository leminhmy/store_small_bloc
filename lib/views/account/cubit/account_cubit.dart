import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';


part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserModel>? _userSubscription;
  AccountCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty? AccountState(status: StatusType.loaded,yourUser: authRepository.currentUser):AccountState(yourUser: UserModel.empty));


  void loadingAccount() async{
    _authRepository.user.listen((uid) async {
      if(uid != ""){
        UserModel userModel = await _authRepository.getInfoUserFirebase(uid);
        emit(state.copyWith(status: StatusType.loading));
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(state.copyWith(status: StatusType.loaded,yourUser: userModel));
      }else{
        emit(state.copyWith(status: StatusType.init,yourUser: UserModel.empty));
      }
    });
  }

  void logoutRequested() async{
    await Future<void>.delayed(const Duration(seconds: 2));
    unawaited(_authRepository.logOut());
    emit(state.copyWith(status: StatusType.init,yourUser: UserModel.empty));
  }


  void logInWithCredentials(String email, String password) async{
    if(state.status == StatusType.loaded) return;
    if(email.isEmpty) {
      emit(state.copyWith(errorMessage: "Email Rỗng"));
    } else if(!email.isValidEmail()){
      emit(state.copyWith(errorMessage: "Email không đúng định dạng"));
    }else if(password.isEmpty){
      emit(state.copyWith(errorMessage: "Password Rỗng"));
    }else if(password.length < 6){
      emit(state.copyWith(errorMessage: "Password tối thiểu 6 kí tự"));
    }else{
      String statusLogin = await _authRepository.logInWithEmailAndPassword(email: email, password: password);
      if(statusLogin =="Login Success"){
        emit(state.copyWith(errorMessage: statusLogin));
      }else{
        emit(state.copyWith(errorMessage: statusLogin));
      }
    }
  }
  void signUpWithCredentials(String email, String password,String name, String phone) async{
    if(state.status == StatusType.loaded) return;
    if(name.isEmpty){
      emit(state.copyWith(errorMessage: "Name Rỗng"));
    }else if(phone.isEmpty){
      emit(state.copyWith(errorMessage: "Phone Rỗng"));
    }
    else if(email.isEmpty) {
      emit(state.copyWith(errorMessage: "Email Rỗng"));
    } else if(!email.isValidEmail()){
      emit(state.copyWith(errorMessage: "Email không đúng định dạng"));
    }else if(password.isEmpty){
      emit(state.copyWith(errorMessage: "Password Rỗng"));
    }else if(password.length < 6){
      emit(state.copyWith(errorMessage: "Password tối thiểu 6 kí tự"));
    }else{
      String statusLogin = await _authRepository.signUpWithEmailAndPassword(email: email, password: password,name: name,phone: phone);
      if(statusLogin =="SignUp Success"){
        emit(state.copyWith(errorMessage: statusLogin));
      }else{
        emit(state.copyWith(errorMessage: statusLogin));
      }
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