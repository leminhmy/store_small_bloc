import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/products/cubit/filter_product_cubit.dart';

import '../../../../app/utils/colors.dart';
import '../../../../models/shoes_type.dart';
import '../../widget/big_text.dart';

class Category extends StatefulWidget {
  const Category({
    Key? key, required this.onChange,
  }) : super(key: key);

  final ValueChanged<int> onChange;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: "Category",fontWeight: FontWeight.bold,color: Colors.black,fontSize: size.height * 0.026,),
          SizedBox(height: size.height * 0.005,),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                if(indexSelected != 0){
                  widget.onChange(0);
                  indexSelected = 0;
                  setState(() {
                  });
                }

              },
              child: Container(
                margin: EdgeInsets.only(right: size.height * 0.01),
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.03,vertical: size.height * 0.01),
                decoration: BoxDecoration(
                  color: indexSelected==0?AppColors.btnClickColor:Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(size.height * 0.01)),
                ),
                child: Center(child: BigText(text: "All",color: Colors.white,fontWeight: FontWeight.bold,)),
              ),
            ),
            BlocBuilder<FilterProductCubit, FilterProductState>(
                buildWhen: (previous, current) =>
                previous.listShoesType != current.listShoesType,
              builder: (context, state) {
                if(state.listShoesType.isNotEmpty){
                  return Row(
                    children: List.generate(state.listShoesType.length, (index) => GestureDetector(
                      onTap: (){
                        if(indexSelected != index + 1){
                          widget.onChange(index+1);
                          indexSelected = index + 1;
                          setState(() {

                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.height * 0.01),
                        padding: EdgeInsets.symmetric(horizontal: size.height * 0.03,vertical: size.height * 0.01),
                        decoration: BoxDecoration(
                          color: indexSelected==(index+1)?AppColors.btnClickColor:Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(size.height * 0.01)),
                        ),
                        child: Center(child: BigText(text: state.listShoesType[index].name!,color: Colors.white,fontWeight: FontWeight.bold,)),
                      ),
                    )),
                  );
                }else{
                  return const SizedBox();
                }
              }
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }
}
