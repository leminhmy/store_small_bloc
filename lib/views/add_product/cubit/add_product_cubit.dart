import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(const AddProductState());


}
