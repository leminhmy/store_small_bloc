part of 'product_cubit.dart';

class ProductState extends Equatable{
  const ProductState({this.status = StatusType.init,this.listProductBanner = const []});

  final StatusType status;
  final List<ProductsModel> listProductBanner;

  @override
  // TODO: implement props
  List<Object?> get props => [status,listProductBanner];

  ProductState copyWith({StatusType? status,List<ProductsModel>? listProductBanner}){
    return ProductState(
        status: status??this.status,
        listProductBanner: listProductBanner??this.listProductBanner,
    );
  }
}