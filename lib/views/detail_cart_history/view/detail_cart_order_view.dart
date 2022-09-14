import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/order.dart';

import '../../../repositories/orders/order_repository.dart';
import '../../widget/show_dialog.dart';
import '../cubit/detail_cart_history_cubit.dart';
import 'detail_cart_history_page.dart';

class DetailCartOrderView extends StatelessWidget {
  const DetailCartOrderView({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => DetailCartHistoryCubit(order: order,orderRepository: OrderRepository()),
        child: BlocListener<DetailCartHistoryCubit, DetailCartHistoryState>(
            listener: (context, state) {
              if(state.errorMessage != ""){
                ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.errorMessage);
              }
            },
          child: BlocBuilder<DetailCartHistoryCubit, DetailCartHistoryState>(
              builder: (context, state) {
                return  DetailCartHistoryPage(name: "Cart Order Setting",order: state.order,settingStatus: true,);
              }
          ),
        ));
  }
}
