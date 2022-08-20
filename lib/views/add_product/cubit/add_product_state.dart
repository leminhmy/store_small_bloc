part of 'add_product_cubit.dart';

class AddProductState extends Equatable{
  final int currentIndex;
  const AddProductState({this.currentIndex = 0});

  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];

}