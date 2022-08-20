import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_small_bloc/app/router/route_name.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/views/add_product/add_product.dart';
import 'package:store_small_bloc/views/cart/cart.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';
import 'package:store_small_bloc/views/detail_product/detail_product.dart';
import 'package:store_small_bloc/views/detail_product/view/detail_product_page.dart';
import 'package:store_small_bloc/views/home/view/home_page.dart';

import '../../views/home/view/home_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.initial:
        if (args != null && args is String) {
          return PageTransition(
              child: const HomeView(
              ),
              type: PageTransitionType.fade);
        }
        return _errRoute();

      case RouteName.shoesDetail:
        if (args != null && args is ProductsModel) {
          return PageTransition(
              child: DetailProductView(
                productsModel: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.messaging:
        if (args != null && args is UserModel) {
          return PageTransition(
              child: ChatMessingView(
                userModel: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.cartPage:
        if (args != null && args is String) {
          return PageTransition(
              child: const CartView(
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.addProduct:
        if (args != null && args is String) {
          return PageTransition(
              child: const AddProductView(
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("no route"),
          ),
        ));
  }
}