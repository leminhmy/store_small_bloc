part of 'account_cubit.dart';

class AccountState extends Equatable{
  final UserModel yourUser;
  final StatusType status;
  final StatusType statusSetData;
  final bool rebuildInfo;
  final String errorMessage;
  const AccountState({this.statusSetData = StatusType.init,this.rebuildInfo = false,this.errorMessage = "",required this.yourUser, this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [statusSetData,rebuildInfo,errorMessage,yourUser, status];

  AccountState copyWith({StatusType? statusSetData,bool? rebuildInfo,StatusType? status,UserModel? yourUser, String? errorMessage}){
    return AccountState(
      status: status??this.status,
      yourUser: yourUser??this.yourUser,
      errorMessage: errorMessage??this.errorMessage,
      rebuildInfo: rebuildInfo??this.rebuildInfo,
      statusSetData: statusSetData??this.statusSetData,
    );
  }

}