import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/type/enum.dart';
import '../../../models/notification.dart';
import '../../../repositories/auth/auth_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super( const NotificationState());


  void loadingNotification(){
    emit(state.copyWith(status: StatusType.loaded,listNotification: []));
  }

  void addNotification(NotificationModel notification){
    state.listNotification.add(notification);
    rebuild();
  }

  void setStatusNotification(){

    for (var element in state.listNotification) {
      element.status = "1";
    }
    rebuild();
  }

  void getListNoti(){
    for (var element in state.listNotification) {
      element.status = "0";
    }
    rebuild();

  }


  void rebuild(){
    emit(state.copyWith(status: StatusType.loading));
    emit(state.copyWith(status: StatusType.loaded));
  }

}
