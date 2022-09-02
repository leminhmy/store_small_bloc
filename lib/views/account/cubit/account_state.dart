part of 'account_cubit.dart';

class AccountState extends Equatable{
  final UserModel yourUser;
  final StatusType status;
  final String errorMessage;
  const AccountState({this.errorMessage = "",required this.yourUser, this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage,yourUser, status];

  AccountState copyWith({StatusType? status,UserModel? yourUser, String? errorMessage}){
    return AccountState(
      status: status??this.status,
      yourUser: yourUser??this.yourUser,
      errorMessage: errorMessage??this.errorMessage,
    );
  }

}