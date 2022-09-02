import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/register/view/register_view.dart';
import 'package:store_small_bloc/views/widget/no_account.dart';

import '../../../core/type/enum.dart';
import '../../login/view/login_view.dart';
import '../../widget/app_loading_widget.dart';



class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) =>
        previous.status != current.status,
      builder: (context, state) {
          print(state.yourUser);
        switch (state.status) {
          case StatusType.init:
            return const Scaffold(body: Center(child: NoAccountWidget()),);
          case StatusType.loading:
            return const AppLoadingWidget();
          case StatusType.loaded:
            return const AccountPage();
          default:
            return const SizedBox();
        }
        return const AccountPage();
      }
    );
  }
}