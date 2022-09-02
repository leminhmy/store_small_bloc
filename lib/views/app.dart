import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/repositories/category/category_repository.dart';
import 'package:store_small_bloc/repositories/map/map_repository.dart';
import 'package:store_small_bloc/repositories/orders/order_repository.dart';
import 'package:store_small_bloc/repositories/products/product_repository.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/edit_product/cubit/edit_product_cubit.dart';
import 'package:store_small_bloc/views/google_map/cubit/google_map_cubit.dart';
import 'package:store_small_bloc/views/history/history.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/products/cubit/filter_product_cubit.dart';
import 'package:store_small_bloc/views/products/cubit/product_cubit.dart';
import 'package:store_small_bloc/views/register/cubit/register_cubit.dart';
import 'package:store_small_bloc/views/register/view/register_view.dart';

import '../app/router/app_router.dart';
import '../logic/cubits/cubits.dart';
import '../repositories/chat/chat_repository.dart';
import 'cart/cubit/cart_cubit.dart';
import 'home/view/home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (BuildContext context) =>
          CartCubit(authRepository: AuthRepository(),orderRepository: OrderRepository())..loadingCart(),
        ),
        BlocProvider<AccountCubit>(
          create: (BuildContext context) => AccountCubit(authRepository: AuthRepository())..loadingAccount(),
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(authRepository: AuthRepository()),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(authRepository: AuthRepository()),
        ),
        BlocProvider<HistoryCubit>(
          create: (BuildContext context) => HistoryCubit(orderRepository: OrderRepository(),authRepository: AuthRepository())..loadingHistory(),
        ),
        BlocProvider<ChatsCubit>(
          create: (BuildContext context) => ChatsCubit(chatRepository: ChatRepository(),authRepository: AuthRepository())..loading(),
        ),

        BlocProvider<ProductCubit>(
          create: (BuildContext context) =>
              ProductCubit(productRepository: ProductRepository())
                ..mapLoadProductState(),
        ),

        BlocProvider<GoogleMapCubit>(
          create: (BuildContext context) => GoogleMapCubit(mapRepository: MapRepository()),

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
    return const MaterialApp(
      title: 'SmallShop',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
