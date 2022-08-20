import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/order.dart';


part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryState(listOrder: demo_order));

}
