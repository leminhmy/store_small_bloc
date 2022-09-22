import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_small_bloc/app/router/route_name.dart';
import 'package:store_small_bloc/models/order.dart';
import 'package:store_small_bloc/models/product.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/account/cubit/account_cubit.dart';
import 'package:store_small_bloc/views/add_product/add_product.dart';
import 'package:store_small_bloc/views/cart/cart.dart';
import 'package:store_small_bloc/views/chat_messing/chat_messing.dart';
import 'package:store_small_bloc/views/detail_cart_history/detail_cart_history.dart';
import 'package:store_small_bloc/views/detail_cart_history/view/detail_cart_order_view.dart';
import 'package:store_small_bloc/views/detail_product/detail_product.dart';
import 'package:store_small_bloc/views/detail_product/view/detail_product_page.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';
import 'package:store_small_bloc/views/home/view/home_page.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/register/view/register_view.dart';

import '../../models/friend.dart';
import '../../views/home/view/home_view.dart';
import '../../views/notification/view/notification_view.dart';

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

      case RouteName.logIn:
        if (args != null && args is String) {
          return PageTransition(
              child: const LoginView(
              ),
              type: PageTransitionType.fade);
        }
        return _errRoute();

      case RouteName.signUp:
        if (args != null && args is String) {
          return PageTransition(
              child: const RegisterView(
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
        if (args != null && args is Friend) {
          return PageTransition(
              child: ChatMessingView(
                friend: args,
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
      case RouteName.location:
        if (args != null && args is String) {
          return PageTransition(
              child:  GoogleMapView(
                routePageTo: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.profile:
        if (args != null && args is String) {
          return PageTransition(
              child:  const AccountView(
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.detailOrder:
        if (args != null && args is Order) {
          return PageTransition(
              child:   DetailCartHistoryView(
                order: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.detailOrderSetting:
        if (args != null && args is Order) {
          return PageTransition(
              child:   DetailCartOrderView(
                order: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.notification:
        if (args != null && args is String) {
          return PageTransition(
              child:  const NotificationView(
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