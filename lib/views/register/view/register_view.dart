import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/register/register.dart';

import '../../../app/router/route_name.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
        listener: (context, state) async {
          if (state.errorMessage == "SignUp Success") {
            await Future<void>.delayed(const Duration(seconds: 2));

            Navigator.pushNamed(
                context, RouteName.initial,
                arguments: "");
          }
        },
        child: const RegisterPage());
  }
}
