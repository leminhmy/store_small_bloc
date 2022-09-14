part of 'register_cubit.dart';

class RegisterState extends Equatable{
  final String errorMessage;
  final StatusType status;

  const RegisterState({this.errorMessage = "",this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage,status];

  RegisterState copyWith({String? errorMessage,StatusType? status}){
    return RegisterState(
      status: status??this.status,
      errorMessage: errorMessage??this.errorMessage,
    );
  }

}