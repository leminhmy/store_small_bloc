import 'package:flutter/material.dart';

import '../components/address_location.dart';
import '../components/app_bar_action.dart';
import '../components/bottom_bar.dart';
import '../components/list_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild cart page");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: const [
            AppBarAction(nameCart: "Cart"),
            AddressLocation(),
            ListCart(),
        ],
      ),
      bottomNavigationBar: const BottomBarCart(),
    );


  }

}


