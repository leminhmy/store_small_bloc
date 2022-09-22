import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/category/category_repository.dart';
import 'package:store_small_bloc/repositories/map/map_repository.dart';
import 'package:store_small_bloc/repositories/notification_service/local_notification.dart';
import 'package:store_small_bloc/repositories/orders/order_repository.dart';
import 'package:store_small_bloc/repositories/products/product_repository.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/edit_product/cubit/edit_product_cubit.dart';
import 'package:store_small_bloc/views/google_map/cubit/google_map_cubit.dart';
import 'package:store_small_bloc/views/history/history.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/notification/notification.dart';
import 'package:store_small_bloc/views/products/cubit/filter_product_cubit.dart';
import 'package:store_small_bloc/views/products/cubit/product_cubit.dart';
import 'package:store_small_bloc/views/register/cubit/register_cubit.dart';
import 'package:store_small_bloc/views/register/view/register_view.dart';

import '../app/router/app_router.dart';
import '../logic/cubits/cubits.dart';
import '../models/notification.dart';
import '../repositories/chat/chat_repository.dart';
import 'cart/cubit/cart_cubit.dart';
import 'home/view/home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthRepository().streamUser();
    AuthRepository().getAllAdmin();
    MapRepository().getLocationHere();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (BuildContext context) =>
          CartCubit(authRepository: AuthRepository(),orderRepository: OrderRepository())..loadingCart(),
        ),

        BlocProvider<GoogleMapCubit>(
          create: (BuildContext context) => GoogleMapCubit(mapRepository: MapRepository()),
        ),

        BlocProvider<ProductCubit>(
          create: (BuildContext context) =>
              ProductCubit(productRepository: ProductRepository())
                ..mapLoadProductState(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit()..loadingNotification(),
        ),

        BlocProvider<FilterProductCubit>(
          create: (BuildContext context) => FilterProductCubit(
              categoryRepository: CategoryRepository(),
              productRepository: ProductRepository())
            ..loadingProducts(),
        ),

      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    NotificationCubit notificationCubit = BlocProvider.of<NotificationCubit>(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(message.data.isNotEmpty){
        notificationCubit.addNotification(NotificationModel.fromJson(message.data));
        print("notification has data");
      }
      // print('Message data: ${NotificationModel.fromJson(message.data).toJson()}');
      if (message.notification != null) {
        LocalNotificationService.createanddisplaynotification(message);
      }
    });
    return const MaterialApp(
      title: 'SmallShop',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
