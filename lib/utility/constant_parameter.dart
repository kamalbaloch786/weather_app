import 'package:flutter/material.dart';
// api with json parameter

//end
// local database  parameter
final String ld_para_id ='id';
final String ld_para_city_name='city_name';
final String ld_para_lat='lat';
final String ld_para_long='long';
final String ld_para_database_name='weather.db';
final String ld_para_city_table_name='citys_name';
final int ld_para_db_version=1;
//
final String app_title='weather app';

final String base_api_url='https://api.openweathermap.org/data/2.5/';
final String weather_doman='weather';
final String forecast_doman='forecast';
final String app_id='3f8d3a66dff678b42321e9d302071908';
final String units='metric';


const primaryColor = Color(0xff2c2c2c);
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greyColor = Color(0xffc4c4c4);
const bgGreyColor = Color(0xfffdfcfc);
const darkGreyColor = Color(0xff9a9a9a);


Widget appText(
    {FontWeight isBold = FontWeight.normal,
      Color color = blackColor,
      required double size,
      required String text,
      int maxLines = 0,
      bool overflow = false,
      bool alignCenter = false}) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overflow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold,
    ),
  );
}


showSnackBar(BuildContext context, String text, {Color color = primaryColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 3,
      content: Text(text, textAlign: TextAlign.center),
    ),
  );
}


Widget customListTile({
  required String first,
  required String second,
  required IconData icon,
  required Color iconColor,
  String text = '',
}) {
  return ListTile(
    trailing: appText(size: 16, text: text, color: darkGreyColor),
    leading: Icon(icon, color: iconColor),
    title: RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style: const TextStyle(
              color: darkGreyColor,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: second,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}


class Constants {
  static const String WEATHER_APP_ID = '3f8d3a66dff678b42321e9d302071908';
  static const String WEATHER_BASE_SCHEME = 'https://';
  static const String WEATHER_BASE_URL_DOMAIN = 'api.weatherapi.com';
  static const String WEATHER_FORECAST_PATH = '/v1/forecast.json';
}
