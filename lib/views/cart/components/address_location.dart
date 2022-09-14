import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/views/google_map/google_map.dart';

import '../../widget/big_text.dart';
import 'open_dialog_edit_location.dart';

class AddressLocation extends StatefulWidget {
  const AddressLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressLocation> createState() => _AddressLocationState();
}

class _AddressLocationState extends State<AddressLocation> {
  late TextEditingController textLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textLocation = TextEditingController(text: "location");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(width: size.height * 0.01,),
        BigText(text: "Địa Chỉ: "),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<GoogleMapCubit, GoogleMapState>(
                buildWhen: (previous, current) => previous.address != current.address,
              builder: (context, state) {
                return BigText(text: state.address,color: Colors.black,fontSize: size.height * 0.022);
              }
            ),),
        ),
        IconButton(onPressed: (){
          OpenDialogLocationEdit.showDialogEditLocation(context: context);
        }, icon: Icon(Icons.edit,color: Colors.black,size: size.height * 0.03,)),
      ],
    );
  }

}