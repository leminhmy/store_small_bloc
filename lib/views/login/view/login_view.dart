import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/login/login.dart';

import '../../../app/router/route_name.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
