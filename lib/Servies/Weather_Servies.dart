import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/weather_current/Weather_model.dart';
import '../utility/constant_parameter.dart';
class Weather_Servies{

  Future<WeatherModel> fetchweather_current(double lat,double long) async {
    final response = await http.get(
      Uri.parse('${base_api_url+weather_doman}?lat=$lat&lon=$long&appid=$app_id&units=$units'),
    );

    if (response.statusCode == 200) {

      return WeatherModel.fromJson(jsonDecode(response.body));

    } else {

      throw Exception('Failed to data ');
    }
  }
}