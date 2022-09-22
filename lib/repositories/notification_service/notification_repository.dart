import 'dart:convert';

import 'package:http/http.dart' as http;
class NotificationRepository{
  String url = "https://fcm.googleapis.com/fcm/send";
  String noImage = "https://firebasestorage.googleapis.com/v0/b/smallshopfirebase.appspot.com/o/image_default%2Fno_image.png?alt=media&token=38abb5f2-d245-44c1-8107-fa377b8f9c80";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'key=AAAAlTN92XY:APA91bEQRUnFEoctXoPXjG8FBfjLbh1SxGOMjtwS5xThndJ7nfGSBwQAsH_5X5FPSpM-OlxsjEElvOQkqstW7xUqwEeyOVqC-qT2PPeqgu_4BPVW9M3PUwy7NPrg33UcKWzpmvCF3Gv3'
  };
  Future<http.Response> sendNotification(
      {required List<String> listTokenMess, required String title, required String content, String? imgUrl, required String name})async{

    var postUri = Uri.parse(url);
    Map<String, dynamic> body = {
      "registration_ids": listTokenMess,
      "notification": {
        "title": title,
        "body": content,
        "android_channel_id": "pushnotificationapp",
        "image": imgUrl??noImage,
        "sound": false
      },
      "data" : {
        "name" : name,
        "title" : title,
        "body":content,
        "image":imgUrl,
        "status": 0,
        "createdAt":DateTime.now().toString(),
        "updatedAt":DateTime.now().toString(),
      }

    };

    final response  = await http.post(postUri,headers: requestHeaders,body: jsonEncode(body));

    if(response.statusCode == 200){
      print("send notification");
    }else{
      print("send notification error");
    }
    return response;
  }

}