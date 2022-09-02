import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/colors.dart';
import '../../../core/type/enum.dart';
import '../../account/cubit/account_cubit.dart';
import '../../widget/app_text_field.dart';
import '../../widget/big_text.dart';
import '../../widget/button_border_radius.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  List<String> listImgLoginMore = [
    'assets/images/g.png',
    'assets/images/f.png',
    'assets/images/t.png',

  ];
  bool isShowVisibility = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state.status == StatusType.init) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.height * 0.02),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/a2.png"),
                      fit: BoxFit.contain,
                    )
                ),
                height: size.height * 0.25,
              ),
              //body signUp infomation
              Column(
                children: [
                  AppTextField(
                    textFieldController: emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email,
                    colorIcon: AppColors.mainColor,
                    onSave: (value) => emailController.text = value!,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  StatefulBuilder(
                      builder: (context, setState2) {
                        return AppTextField(
                          onSave: (value) => passwordController.text = value!,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState2(() {
                                isShowVisibility = !isShowVisibility;
                              });
                            },
                            icon: isShowVisibility ? const Icon(
                                Icons.visibility_off) : const Icon(
                                Icons.visibility),
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
                  AppTextField(
                    onSave: (value) => phoneController.text = value!,
                    textFieldController: phoneController,
                    hintText: "Phone",
                    prefixIcon: Icons.phone_android_outlined,
                    colorIcon: AppColors.mainColor,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppTextField(
                    onSave: (value) => nameController.text = value!,
                    textFieldController: nameController,
                    hintText: "Name",
                    prefixIcon: Icons.person,
                  ),
                ],
              ),
              //Sign up and Sign in other ways
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AccountCubit>().signUpWithCredentials(
                          emailController.text, passwordController.text, nameController.text, phoneController.text);
                    },
                    child: ButtonBorderRadius(
                      widget: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: size.height * 0.02),
                        child: BigText(
                            text: "Sign Up",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.026),
                      ),
                      colorBackground: AppColors.mainColor,
                      borderRadius: size.height * 0.026,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, RouteName.logIn,
                                arguments: ""),
                          text: "Have an account already?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: size.height * 0.02,
                          ))),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Sign up using one of the following methos",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: size.height * 0.016,
                          ))),
                  Wrap(
                    children: List.generate(
                        listImgLoginMore.length,
                            (index) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: size.height * 0.03,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                    listImgLoginMore[index]),
                              ),
                            )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



