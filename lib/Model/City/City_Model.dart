import 'dart:convert';
import '../../utility/constant_parameter.dart';


List<City_Model> todoFromJson(String str) =>
    List<City_Model>.from(json.decode(str).map((x) => City_Model.fromJson(x)));
class City_Model {
  int? id;
  String? city_name;
  double? lat;
  double? long;

  City_Model({this.id, this.city_name, this.lat, this.long});

  factory City_Model.fromJson(Map<String, dynamic> json) {
    return City_Model(
        city_name: json[ld_para_city_name],
        lat: json[ld_para_lat],
        long: json[ld_para_long]);
  }

  Map<String, dynamic> toMap() {
    return {
       ld_para_id:id,
      ld_para_city_name: city_name,
      ld_para_lat: lat,
      ld_para_long: long,
    };
  }
}
