import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/orders/order_repository.dart';
import 'package:store_small_bloc/views/detail_cart_history/detail_cart_history.dart';

import '../../../models/order.dart';

class DetailCartHistoryView extends StatelessWidget {
  const DetailCartHistoryView({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DetailCartHistoryCubit(order: order,),
        child: BlocBuilder<DetailCartHistoryCubit, DetailCartHistoryState>(
          builder: (context, state) {
            return  DetailCartHistoryPage(name: "Cart History",order: state.order,);
          }
        ));
  }
}
