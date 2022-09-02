import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/register/register.dart';

import '../../../app/router/route_name.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if(state.errorMessage != ""){
            if(state.errorMessage.contains("Error")){
              ShowSnackBarWidget.showSnackCustom(context: context,isError: true,text: state.errorMessage);
            }else{
              ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.errorMessage);
              if(state.errorMessage == "Register Success"){
                await Future<void>.delayed(const Duration(seconds: 3),(){
                  Navigator.pushNamed(
                      context, RouteName.initial,
                      arguments: "");
                  context.read<AccountCubit>().loadingAccount();

                });
              }
            }
          }

        },
        child: const RegisterPage());
  }
}
