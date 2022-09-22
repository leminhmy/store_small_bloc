import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/views/account/account.dart';
import 'package:store_small_bloc/views/login/login.dart';
import 'package:store_small_bloc/views/widget/show_dialog.dart';
import 'package:store_small_bloc/views/widget/show_snack_bar.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../widget/app_text_field.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowVisibility = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.03),
                height: size.height * 0.3,
                alignment: Alignment.topRight,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image:  DecorationImage(
                      image: AssetImage("assets/images/a2.png"),
                      fit: BoxFit.contain,
                    )
                ),
                child: IconButton(onPressed: () => Navigator.pushNamed(
                    context, RouteName.initial,
                    arguments: ""),icon: const Icon(Icons.home,color: Colors.green,),iconSize: 30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Hello",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.065,
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: size.height * 0.02,
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              //input signIn
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTextField(
                      onSave: (value) => emailController.text = value!,
                      textFieldController: emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      colorIcon: AppColors.mainColor,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    StatefulBuilder(
                        builder: (context, setState2) {
                          return AppTextField(
                            onSave: (value) => passwordController.text = value!,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState2(() {
                                  isShowVisibility =!isShowVisibility;

                                });
                              },
                              icon: isShowVisibility?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                            ),
                            isObscure: isShowVisibility,
                            textFieldController: passwordController,
                            hintText: "Password",
                            prefixIcon: Icons.password,
                            colorIcon: AppColors.mainColor,
                          );
                        }
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.height * 0.02),
                      child: RichText(
                          text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: size.height * 0.02,
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<LoginCubit>().logInWithCredentials(emailController.text, passwordController.text);
                        },
                        child: ButtonBorderRadius(
                          widget: Container(
                            margin: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                            child: BigText(
                                text: "Sign In",
                                color: Colors.white,
                                fontSize: size.height * 0.026),
                          ),
                          colorBackground: AppColors.mainColor,
                          borderRadius: size.height * 0.026,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: size.height * 0.02,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pushNamed(
                                    context, RouteName.signUp,
                                    arguments: ""),
                                text: "Create",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ]
                        ),

                      ),

                    ],
                  ),


                ],
              ),

            ],
          ),
        )
    );
  }
}
