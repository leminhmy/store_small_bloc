part of 'detail_product_cubit.dart';

class DetailProductState extends Equatable {
  final ProductsModel productsModel;
  final int size;
  final String color;
  final int current;
  final String? idCart;
  final StatusType status;

  const DetailProductState(

      {required this.productsModel,
        this.idCart,
        this.current = 0,
      this.color = '0xffffffff',
        this.status = StatusType.init,
      this.size = 20});

  @override
  // TODO: implement props
  List<Object?> get props => [idCart,productsModel,size,color,current,status];

  DetailProductState copyWith(
      {String? idCart,ProductsModel? productsModel, int? current, String? color, int? size, StatusType? status}) {
    return DetailProductState(
        productsModel: productsModel ?? this.productsModel,
        size: size ?? this.size,
        idCart: idCart??this.idCart,
        color: color ?? this.color,
        status: status??this.status,
        current: current ?? this.current);
  }
}
