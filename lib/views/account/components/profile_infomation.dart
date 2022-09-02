import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/models/user_model.dart';
import 'package:store_small_bloc/repositories/auth/auth_repository.dart';
import 'package:store_small_bloc/views/account/cubit/account_cubit.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../widget/icon_and_text_full_contailer.dart';

class ProfileInfomation extends StatelessWidget {
  const ProfileInfomation({
    Key? key, required this.yourUser, required this.clicked,
  }) : super(key: key);

  final UserModel yourUser;
  final ValueChanged<bool> clicked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("rebuild profile_info");
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                IconAndTextFullContainer(
                  colorBackground: AppColors.mainColor,
                  iconData: Icons.person,
                  text: "${yourUser.name!} - ${yourUser.status == 2?"(Admin)":"(User)"}",
                ),
                SizedBox(height: size.height * 0.02,),
                IconAndTextFullContainer(
                  colorBackground: AppColors.iconColor1,
                  iconData: Icons.phone,
                  text: yourUser.phone!.toString(),
                ),
                SizedBox(height: size.height * 0.02,),
                GestureDetector(
                  onTap: () {
                  },
                  child: IconAndTextFullContainer(
                    colorBackground: AppColors.iconColor1,
                    iconData: Icons.email,
                    text: yourUser.email!,
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                        context, RouteName.location,
                        arguments: "account");
                  },
                  child: IconAndTextFullContainer(
                    colorBackground: AppColors.iconColor1,
                    iconData: Icons.location_on_rounded,
                    text: yourUser.address??"Fill in the address",
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                const IconAndTextFullContainer(
                  colorBackground: AppColors.redColor,
                  iconData: Icons.message,
                  text: "message",
                ),
                SizedBox(height: size.height * 0.02,),
                GestureDetector(
                  onTap: (){
                    clicked(true);
                    context.read<AccountCubit>().logoutRequested();
                  },
                  child:const IconAndTextFullContainer(
                    colorBackground: AppColors.redColor,
                    iconData: Icons.logout,
                    text: "Logout",
                  ),
                ),
                SizedBox(height: size.height * 0.02,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
