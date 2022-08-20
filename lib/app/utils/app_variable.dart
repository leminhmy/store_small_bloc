import 'package:intl/intl.dart';

class AppVariable{


  static String numberFormatPriceVi(var price){
    String number =  NumberFormat.currency(
        locale: 'vi',symbol: 'đ', decimalDigits: 0
    ).format(price);

    return number;

  }
  static String timeFormat(String time) {
    var outputDate = DateTime.now().toString();
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

}