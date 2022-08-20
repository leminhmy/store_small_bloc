import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/chats/chats.dart';
import 'package:store_small_bloc/views/history/history.dart';
import 'package:store_small_bloc/views/products/products.dart';
import 'package:store_small_bloc/views/widget/big_text.dart';

import '../../../app/utils/colors.dart';
import '../../widget/small_text.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List page = [
      const ProductView(),
      const ChatsView(),
      const HistoryView(),
      const AccountView(),
      // CartHistoryPage(),
      // AccountPage(),
    ];
    void onTapNav(int index) => context.read<HomeCubit>().changeIndex(index);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: page[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.amberAccent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: state.currentIndex,
            onTap: onTapNav,
            items: [
             const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home",

              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.messenger),
                    Positioned(
                      right: -size.height * 0.01,
                      top: -size.height * 0.01,
                      child: CircleAvatar(
                        maxRadius: size.height * 0.01,
                        backgroundColor: Colors.red,
                        child: SmallText(text: "1",color: Colors.white),
                      ),
                    )
                  ],
                ),
                label: "mess",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "cart history",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "me",
              ),
            ],
          ),
        );
      },
    );
  }
}