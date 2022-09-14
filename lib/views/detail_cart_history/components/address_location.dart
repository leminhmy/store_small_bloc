import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';

import '../../widget/big_text.dart';



class AddressLocation extends StatelessWidget {
  const AddressLocation({Key? key, required this.address, required this.orderId}) : super(key: key);
  final String address;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: size.height * 0.01,),
            BigText(text: "Địa Chỉ: ",fontSize: size.height * 0.022),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BigText(text: address,color: Colors.black,fontSize: size.height * 0.022),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: size.height * 0.01,),
            BigText(text: "Order ID:  ",fontSize: size.height * 0.022),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BigText(text: orderId,color: Colors.red,fontSize: size.height * 0.022),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
