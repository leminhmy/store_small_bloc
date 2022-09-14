import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_small_bloc/app/utils/time_ago.dart';

import '../../views/widget/small_text.dart';

class AppVariable{


  static String numberFormatPriceVi(var price){
    String number =  NumberFormat.currency(
        locale: 'vi',symbol: 'đ', decimalDigits: 0
    ).format(price);

    return number;

  }
  static String timeFormat(String time) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(time);
    DateFormat outputFormat = DateFormat.yMd().add_Hm();
    String outputDate = outputFormat.format(parseDate);
    return outputDate;
  }
  static String timeAgoFormat(String time) {

    if(time.isNotEmpty){
      var outputDate = DateTime.now().toString();
      DateTime parseDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
      outputDate = outputFormat.format(inputDate);

      return TimeAgo.timeAgoSinceDate(parseDate);
    }
    return "";

  }

  static ScaffoldMessengerState showErrorSnackBar(BuildContext context, String? error){
   return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
        ),
      );
  }

  static ScaffoldMessengerState showErrorSnackBar(BuildContext context, String? error){
   return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
        ),
      );
  }

}