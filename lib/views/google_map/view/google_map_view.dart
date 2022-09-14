import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/map/map_repository.dart';
import '../../account/cubit/account_cubit.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';
import '../cubit/google_map_cubit.dart';
import 'google_map_page.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({Key? key,this.routePageTo = ""}) : super(key: key);

  final String routePageTo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild widget googlemap view");
    return  BlocListener<GoogleMapCubit, GoogleMapState>(
        listener: (context, state) async {
          if(state.errorMessage != ""){
            print("page to account");
            ShowDialogWidget.showDialogDefaultBloc(context: context, status: state.status, text: state.errorMessage);
            if(state.errorMessage.contains("Địa chỉ") && routePageTo == "account"){
              String getStatusUpdate = await context.read<AccountCubit>().updateLocationUser(state.address);
              if(getStatusUpdate == "Success"){
                ShowSnackBarWidget.showSnackCustom(context: context,text: "Update Address Success");
              }else{
                ShowSnackBarWidget.showSnackCustom(context: context,isError: true,text: getStatusUpdate);
              }
            }
          }
        },
        child: const GoogleMapPage());
  }
}
