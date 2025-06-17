import 'dart:convert';

import 'package:weather_app/Modals/WeatherModal.dart';
import 'package:http/http.dart' as http;

class WeatherStates {
  // Future<List<WeatherModal>> getApi() async {
  //
  //   final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=4d19a30d322c4c56b2c73339251606&q=Bannu&aqi=yes'));
  //   var data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200){
  //
  //   }else{
  //
  //   }
  // }
  Future<WeatherModal> getProductsApi()async{
    final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=4d19a30d322c4c56b2c73339251606&q=Bannu&aqi=yes'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(data);
      return WeatherModal.fromJson(data);
    }else{
     return WeatherModal.fromJson(data);
    }
  }

}
