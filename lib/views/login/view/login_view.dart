import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/login/login.dart';

import '../../../app/router/route_name.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => LoginCubit(authRepository: AuthRepository()),
      child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if(state.errorMessage != ""){
              if(state.errorMessage.contains("Email") || state.errorMessage.contains("Password")){
                ShowSnackBarWidget.showSnackCustom(context: context,isError: true,text: state.errorMessage);
              }else{
                ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.errorMessage);
                if(state.errorMessage == "Login Success"){
                  await Future<void>.delayed(const Duration(seconds: 3),(){
                    Navigator.pushNamed(
                        context, RouteName.initial,
                        arguments: "");

                  });
                }
              }
            }

          },
          child: const LoginPage()),
    );
  }
}
