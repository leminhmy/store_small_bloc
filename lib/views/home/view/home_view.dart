import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/cart/cart.dart';

import '../../products/cubit/filter_product_cubit.dart';
import '../../products/cubit/product_cubit.dart';
import '../cubit/home_cubit.dart';
import 'home_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: const HomePage(),
    );
  }
}