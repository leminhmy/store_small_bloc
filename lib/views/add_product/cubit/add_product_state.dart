part of 'add_product_cubit.dart';

class AddProductState extends Equatable{
  final String messError;
  final StatusType status;
  const AddProductState({this.messError = "", this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [messError,status];

  AddProductState copyWith({String? messError,StatusType? status}){
    return AddProductState(
      messError: messError??this.messError,
      status: status??this.status,
    );
  }


}