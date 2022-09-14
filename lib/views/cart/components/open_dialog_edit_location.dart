import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';
import 'package:store_small_bloc/views/widget/show_snack_bar.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../widget/app_text_field.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';

class OpenDialogLocationEdit{
  static void showDialogEditLocation({required BuildContext context}){
    showDialog(
      barrierDismissible: false,
        context: context, builder: (context) {
      return const WidgetEditLocation();
    });
  }
}

class WidgetEditLocation extends StatefulWidget {
  const WidgetEditLocation({Key? key}) : super(key: key);

  @override
  State<WidgetEditLocation> createState() => _WidgetEditLocationState();
}

class _WidgetEditLocationState extends State<WidgetEditLocation> {
  TextEditingController textEditLocation = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: size.height * 0.3,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(text: "Map",color: Colors.black,fontSize: 25),
                  IconButton(onPressed: () => Navigator.pushNamed(
                      context, RouteName.location,
                      arguments: ""), icon: const Icon(Icons.map,color: Colors.green,size: 40,),)
                ],
              ),
              const SizedBox(height: 10,),
              BlocBuilder<GoogleMapCubit, GoogleMapState>(
                  buildWhen: (previous, current) => previous.address != current.address,
                builder: (context, state) {
                  return StatefulBuilder(
                      builder: (context, setState) {
                        textEditLocation.addListener(() => setState((){}));
                        return BigText(text: "${textEditLocation.text}, ${state.address}",color: Colors.black,fontSize: 25);
                      }
                  );
                }
              ),
              const SizedBox(height: 10,),
              AppTextField(
                onSave: (value) => textEditLocation.text = value!,
                textFieldController: textEditLocation,
                hintText: "Địa chỉ cụ thể",
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.location_on_rounded,
                colorIcon: AppColors.mainColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<GoogleMapCubit, GoogleMapState>(
                      buildWhen: (previous, current) => previous.address != current.address,
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if(textEditLocation.text.isEmpty || state.address == ""){
                            ShowSnackBarWidget.showSnackCustom(context: context,isError: true,text: "Address or Map input is Empty");
                          }else{
                              context.read<GoogleMapCubit>().changeLocation(textEditLocation.text);
                              Navigator.pop(context);
                          }
                        },
                        child: ButtonBorderRadius(
                          widget: BigText(
                            text: "Accpet",
                            color: Colors.white,
                          ),
                          colorBackground: AppColors.mainColor,
                        ),
                      );
                    }
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: ButtonBorderRadius(
                      widget: BigText(
                        text: "Cancel",
                        color: Colors.white,
                      ),
                      colorBackground: AppColors.mainColor,
                    ),
                  ),
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}