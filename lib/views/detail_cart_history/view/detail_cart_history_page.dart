import 'package:flutter/material.dart';
import 'package:store_small_bloc/models/order.dart';
import 'package:store_small_bloc/views/detail_cart_history/components/bottom_bar_cart_setting.dart';

import '../../widget/big_text.dart';
import '../components/address_location.dart';
import '../components/app_bar_action.dart';
import '../components/bottom_bar.dart';
import '../components/list_cart.dart';



class DetailCartHistoryPage extends StatelessWidget {
  const DetailCartHistoryPage({Key? key, required this.order, required this.name, this.settingStatus = false}) : super(key: key);

  final Order order;
  final String name;
  final bool settingStatus;

  @override
  Widget build(BuildContext context) {
    print("rebuild widget cart history");
    return Scaffold(
      body: Column(
        children:  [
          Expanded(child: Column(
            children: [
              AppBarAction(nameCart: name),
              AddressLocation(address: order.address!,orderId: order.id!),

              ListCart(listCart: order.orderItems!),
            ],
          )),
          settingStatus == false?BottomBarCart(totalPrice: order.orderAmount!):BottomBarCartSetting(totalPrice: order.orderAmount!,statusOrder: order.status!,),
        ],
      ),
    );
  }
}
