import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context)
  {
    const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? id )async{
      print("onSelectNotification");
      if (id!.isNotEmpty) {
        print("Router Value1234 $id");

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DemoScreen(
        //       id: id,
        //     ),
        //   ),
        // );


      }
    });


  }





  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      _downloadAndSaveFile(String url, String fileName) async{
        var directory  = await getApplicationDocumentsDirectory();
        var filePath = '${directory.path}/$fileName';
        var response = await http.get(Uri.parse(url));
        var file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;

      }

     /* var attachmentPicture = await _downloadAndSaveFile(message.notification!.android!.imageUrl!, 'iconUser.jpg');

      final styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(attachmentPicture),

      );*/

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          // styleInformation: styleInformation,
          // largeIcon: FilePathAndroidBitmap(attachmentPicture),
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print("eror: notification local: "+e.toString());
    }
  }

}