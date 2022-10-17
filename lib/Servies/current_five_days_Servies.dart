import 'dart:convert';
import '../Model/Weather_current_five_dates/Current_five_day_model.dart';
import 'package:http/http.dart 'as http;
import '../utility/constant_parameter.dart';

class current_five_days_Servies{
  Future<current_five_days_model> fetchweather_current_forecast(double lat,double long) async {
    final response = await http.get(
      Uri.parse('${base_api_url+forecast_doman}?lat=$lat&lon=$long&appid=$app_id&units=$units'),
    );

    if (response.statusCode == 200) {

      return current_five_days_model.fromJson(jsonDecode(response.body));

    } else {

      throw Exception('Failed to data ');
    }
  }
}