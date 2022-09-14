part of 'login_cubit.dart';

class LoginState extends Equatable{
  final String errorMessage;
  final StatusType status;

  const LoginState({this.errorMessage = "",this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage,status];

  LoginState copyWith({String? errorMessage,StatusType? status}){
    return LoginState(
      status: status??this.status,
      errorMessage: errorMessage??this.errorMessage,
    );
  }

}