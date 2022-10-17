import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../Model/City/City_Model.dart';
import '../Model/Weather_current_five_dates/Current_five_day_model.dart';
import '../Model/weather_current/Weather_model.dart';
import '../Servies/Weather_Servies.dart';
import '../Servies/current_five_days_Servies.dart';
import '../helper/DatabaseHelper.dart';

class City_Controller extends GetxController {
  RxList<City_Model> list_of_city = <City_Model>[].obs;

  List<City_Model> get city => list_of_city;
  final servies_weather = Weather_Servies();
  final servies_current_five_days_weather = current_five_days_Servies();
  final List<WeatherModel> list_current_weather = [];
  current_five_days_model? current_five_days_m;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  WeatherModel? current_weather;
  Rx<List<City_Model>> city_model_list = Rx<List<City_Model>>([]);
  RxBool api_status = false.obs;
  bool status_api_five_days=false;
  List<WeatherModel>? list_wether;

  Rx<List<WeatherModel>> list_current = Rx<List<WeatherModel>>([]);

  void getdata_five_days(double lat, double long) async {
    current_five_days_m = await servies_current_five_days_weather
        .fetchweather_current_forecast(lat!, long!);
    status_api_five_days=true;
    print('now data is ${current_five_days_m!.listW}');
    update();
  }

  void bindind(double lat, double long) async {
    // api_status.value=false;

    current_weather = await servies_weather.fetchweather_current(lat!, long!);

    list_current_weather.add(current_weather!);
    //list_wether!.a(current_weather!);
    // print('data model ${list_wether}');
    Future.delayed(Duration(seconds: 1));
    api_status.value = true;
    print('current data is => ${list_current_weather}');

    update();
  }

  remove_list(int index) {
    list_current_weather.removeAt(index);
    update();
  }

  void deletecity(int id) async {
    final data = City_Model(
      id: id,
    );
    await DatabaseHelper.instance.delete_city(data);

    update();
  }

  @override
  void onReady() {
    // bindind_local_data_with_api_listing();

    //  datafatch(	35.920834,	74.308334);
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    checkGps();
    //dilog();

    // bindind();
    update();
    // datafatch(	35.920834,	74.308334);
    // TODO: implement onInit
    super.onInit();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        update();

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    update();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    getdata_five_days(position.latitude, position.longitude);

    update();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      update();
    });
  }


    }



