part of 'cart_cubit.dart';

class CartState extends Equatable{
  final List<CartModel> listCart;
  final StatusType status;
  final int indexCart;
  final bool rebuild;
  final String messError;

  const CartState({this.messError = "",this.rebuild = false,this.indexCart = -1,this.listCart = const [],this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [messError,rebuild,listCart,status,indexCart];

  CartState copyWith({String? messError,bool? rebuild,StatusType? status,List<CartModel>? listCart,int? indexCart}){
    return CartState(
      status: status??this.status,
      indexCart: indexCart??this.indexCart,
      listCart: listCart??this.listCart,
      rebuild: rebuild??this.rebuild,
      messError: messError??this.messError,
    );
  }

}