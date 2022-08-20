part of 'cart_cubit.dart';

class CartState extends Equatable{
  final List<CartModel> listCart;
  final StatusType status;
  final int indexCart;
  const CartState({this.indexCart = -1,this.listCart = const [],this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [listCart,status,indexCart];

  CartState copyWith({StatusType? status,List<CartModel>? listCart,int? indexCart}){
    return CartState(
      status: status??this.status,
      indexCart: indexCart??this.indexCart,
      listCart: listCart??this.listCart,
    );
  }

}