import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/type/enum.dart';
import '../../../repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository}) :
        _authRepository = authRepository, super( const LoginState());

  void logInWithCredentials(String email, String password) async{
    emit(state.copyWith(errorMessage: ""));
    if(email.isEmpty) {
      emit(state.copyWith(errorMessage: "Email Rỗng"));
    } else if(!email.isValidEmail()){
      emit(state.copyWith(errorMessage: "Email không đúng định dạng"));
    }else if(password.isEmpty){
      emit(state.copyWith(errorMessage: "Password Rỗng"));
    }else if(password.length < 6){
      emit(state.copyWith(errorMessage: "Password tối thiểu 6 kí tự"));
    }else{
      emit(state.copyWith(errorMessage: "Đang kiểm tra",status: StatusType.loading));
      String statusLogin = await _authRepository.logInWithEmailAndPassword(email: email, password: password);
      if(statusLogin == "Login Success"){
        emit(state.copyWith(errorMessage: statusLogin,status: StatusType.loaded));
      }else{
        emit(state.copyWith(errorMessage: statusLogin,status: StatusType.error));
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