import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit()
      : super(AuthRepository.currentUser.isNotEmpty
            ? AccountState(
                status: StatusType.loaded, yourUser: AuthRepository.currentUser)
            : AccountState(yourUser: UserModel.empty, status: StatusType.init));

   loadingAccount() async {
     if (AuthRepository.currentUser.isNotEmpty) {
       AuthRepository().streamAccount().listen((event) {
         rebuildAccount();
       });
       emit(state.copyWith(
           yourUser: AuthRepository.currentUser,
           status: StatusType.loaded,
           errorMessage: ""));
     } else {
       emit(state.copyWith(
           yourUser: UserModel(id: ""),
           status: StatusType.init,
           errorMessage: ""));
     }
  }


  printAccount() {
    emit(state.copyWith(status: StatusType.init));
  }

  void rebuildAccount() {
    emit(state.copyWith(yourUser: AuthRepository.currentUser,errorMessage: ""));
    emit(state.copyWith(rebuildInfo: false));
    emit(state.copyWith(rebuildInfo: true));
  }

  void logoutRequested() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    unawaited(AuthRepository().logOut());
    emit(state.copyWith(status: StatusType.init,errorMessage: ""));

  }

  void updateAccount(
      {required String name, required String phone, XFile? image}) async {
    print("start fn updateAccount");
    emit(state.copyWith(errorMessage: ""));
    if (name.isEmpty) {
      emit(state.copyWith(errorMessage: "Name is Empty"));
    } else if (phone.isEmpty) {
      emit(state.copyWith(errorMessage: "Phone is Empty"));
    } else {
      emit(state.copyWith(
          errorMessage: "Updating", statusSetData: StatusType.loading));
      String? urlImageInfo;
      if (image != null) {
        urlImageInfo = await AuthRepository().uploadImageUser(image);
      }
      if (urlImageInfo == "Error") {
        emit(state.copyWith(
            errorMessage: "Image error", statusSetData: StatusType.error));
      } else {
        Map<String, dynamic> updateProfileInfo = {
          "name": name,
          "phone": int.parse(phone),
          "image": urlImageInfo
        };
        String statusUpdateInfo =
            await AuthRepository().updateAccount(updateProfileInfo);
        if (statusUpdateInfo == "Success") {
          emit(state.copyWith(
              errorMessage: statusUpdateInfo,
              statusSetData: StatusType.loaded));
          await Future<void>.delayed(const Duration(seconds: 2));
        } else {
          emit(state.copyWith(errorMessage: "Error update profile"));
        }
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
