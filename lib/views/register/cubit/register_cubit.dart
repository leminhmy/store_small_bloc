import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/type/enum.dart';
import '../../../repositories/auth/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit({required AuthRepository authRepository}) :
        _authRepository = authRepository, super( const RegisterState());

  void signUpWithCredentials(String email, String password,String name, String phone) async{
    emit(state.copyWith(errorMessage: ""));
    if(name.isEmpty){
      emit(state.copyWith(errorMessage: "Error: Name Rỗng"));
    }else if(phone.isEmpty){
      emit(state.copyWith(errorMessage: "Error: Phone Rỗng"));
    } else if(email.isEmpty) {
      emit(state.copyWith(errorMessage: "Error: Email Rỗng"));
    } else if(!email.isValidEmail()){
      emit(state.copyWith(errorMessage: "Error: Email không đúng định dạng"));
    }else if(password.isEmpty){
      emit(state.copyWith(errorMessage: "Error: Password Rỗng"));
    }else if(password.length < 6){
      emit(state.copyWith(errorMessage: "Error: Password tối thiểu 6 kí tự"));
    }else{
      emit(state.copyWith(errorMessage: "Đang kiểm tra",status: StatusType.loading));
      String statusLogin = await _authRepository.signUpWithEmailAndPassword(email: email, password: password,name: name,phone: int.parse(phone));
      if(statusLogin == "Register Success"){
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