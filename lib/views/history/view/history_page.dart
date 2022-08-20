import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/history/components/hearder_app_bar.dart';
import 'package:store_small_bloc/views/history/components/history_card.dart';
import 'package:store_small_bloc/views/history/history.dart';

import '../../../models/order.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          List<Order> listOrder = state.listOrder;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarCustom(namePage: "History"),
              //ListCart history
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: ListView.builder(
                      itemCount: listOrder.length,
                      itemBuilder: (context, index){
                        return HistoryCard(order: listOrder[index],);
                      }),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

}
