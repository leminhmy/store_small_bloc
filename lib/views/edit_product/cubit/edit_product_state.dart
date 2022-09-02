
part of 'edit_product_cubit.dart';



class EditProductState extends Equatable{
  final ProductsModel product;
  final bool onTapEvent;
  final String messError;
  final StatusType status;
  const EditProductState({required this.product, this.onTapEvent = false, this.messError = "", this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [product, onTapEvent, messError, status];

  EditProductState copyWith({ProductsModel? product, bool? onTapEvent, String? messError, StatusType? status}){
    return EditProductState(
        product: product??this.product,
      onTapEvent: onTapEvent??this.onTapEvent,
      messError: messError??this.messError,
      status: status??this.status,
    );
  }

}