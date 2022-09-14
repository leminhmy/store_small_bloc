

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class MapRepository{

  final String _keyMap = "4f75e5121d8c4b11884ecbf83307bc94";

   Future<String> getLocation(LatLng position) async{
    String urlMap = "https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&apiKey=$_keyMap";
    Response response = await get(Uri.parse(urlMap));
    try{
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = await jsonDecode(response.body);
        String location = await decodedData["features"][0]["properties"]["formatted"];
        return location;
      } else {
        print("Fail Request ${response.statusCode}");
        return "Fail Get Request ${response.statusCode}";
      }
    }catch(error){
      print("Fail Get Request");
      return "Fail Get Request";
    }

  }

}