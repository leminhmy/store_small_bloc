import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/register/view/register_view.dart';
import 'package:store_small_bloc/views/widget/no_account.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';
import 'package:store_small_bloc/views/widget/show_snack_bar.dart';

import '../../../core/type/enum.dart';
import '../../login/view/login_view.dart';
import '../../widget/app_loading_widget.dart';



class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if(state.errorMessage != ""){
          if(state.errorMessage.contains("Empty")){
            ShowSnackBarWidget.showSnackCustom(context: context,isError: true,text: state.errorMessage);
          }else{
            ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.errorMessage);
          }
        }
      },
      child: BlocBuilder<AccountCubit, AccountState>(
          buildWhen: (previous, current) =>
          previous.status != current.status,
        builder: (context, state) {
          print("rebuild account page");
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
        }
      ),
    );
  }
}