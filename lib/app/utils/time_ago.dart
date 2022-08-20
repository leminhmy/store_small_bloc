import 'package:intl/intl.dart';

class TimeAgo{
  static String timeAgoSinceDate(DateTime dateTime){
    var timeNow = DateTime.now();
    var diff = timeNow.difference(dateTime);

    if(diff.inDays > 8) {
      return DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime);
    } else if((diff.inDays / 7).floor() >=1) {
      return 'Last week';
    } else if(diff.inDays >= 2) {
      return '${diff.inDays} days ago';
    } else if(diff.inDays >= 1) {
      return '1 day ago';
    } else if(diff.inHours >= 2) {
      return '${diff.inHours} hours ago';
    } else if(diff.inHours >= 1) {
      return '1 hour ago';
    } else if(diff.inMinutes >= 2) {
      return '${diff.inMinutes} minutes ago';
    } else if(diff.inMinutes >= 1) {
      return '1 minutes ago';
    } else if(diff.inSeconds >= 3) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}