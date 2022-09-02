
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/core/type/enum.dart';
import 'package:store_small_bloc/views/add_product/add_product.dart';

import 'package:store_small_bloc/views/add_product/components/build_appbar.dart';
import 'package:store_small_bloc/views/widget/show_snack_bar.dart';

import '../../widget/show_dialog.dart';
import '../components/build_body.dart';



class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AddProductCubit, AddProductState>(
      listener: (context, state) {
        ShowSnackBarWidget.showSnackBarDefault(context: context, text: state.messError);
        ShowDialogWidget.showDialogDefaultBloc(context: context,status: state.status,text: state.messError);

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
            child: BuildAppBar()),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
              color: Colors.yellow,
              image: const DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(size.height * 0.02), topLeft: Radius.circular(size.height * 0.02))),
          child: const SingleChildScrollView(
            child: BuildBody(),
          ),
        ),
      ),
    );
  }
}





