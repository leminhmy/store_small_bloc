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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AppBarCustom(namePage: "History"),
          //ListCart history
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.height * 0.02),
              child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    return ListView.builder(
                        itemCount: state.listOrder.length,
                        itemBuilder: (context, index){
                          return HistoryCard(order: state.listOrder[index],index: index,);
                        });
                  }
              ),
            ),
          ),
        ],
      )
    );
  }

}
