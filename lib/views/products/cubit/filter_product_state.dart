part of 'filter_product_cubit.dart';

class FilterProductState extends Equatable{
  const FilterProductState({this.listShoesType = const [],this.status = StatusType.init,this.listProduct = const []});

  final StatusType status;
  final List<ShoesTypeModel> listShoesType;
  final List<ProductsModel> listProduct;

  @override
  // TODO: implement props
  List<Object?> get props => [status,listProduct,listShoesType];

  FilterProductState copyWith({StatusType? status,List<ProductsModel>? listProduct,List<ShoesTypeModel>? listShoesType}){
    return FilterProductState(
      status: status??this.status,
      listShoesType: listShoesType??this.listShoesType,
      listProduct: listProduct??this.listProduct,
    );
  }
}