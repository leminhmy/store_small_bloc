part of 'notification_cubit.dart';

class NotificationState extends Equatable{
  final StatusType status;
  final List<NotificationModel> listNotification;

  const NotificationState({this.status = StatusType.init,this.listNotification = const []});

  @override
  List<Object?> get props => [status, listNotification];

  NotificationState copyWith({StatusType? status,List<NotificationModel>? listNotification}){
    return NotificationState(
      status: status??this.status,
      listNotification: listNotification??this.listNotification,
    );
  }

}