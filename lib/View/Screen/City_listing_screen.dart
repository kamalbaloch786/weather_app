import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart' as web;
import 'package:flutter_google_places/flutter_google_places.dart' as google;
import '../../Controller/City_Controller.dart';
import '../../Model/City/City_Model.dart';

const kGoogleApiKey = "AIzaSyBdh9sFWxjJLcYEmssq73oQg-etg2cCyac";

class City_listing_screen extends StatefulWidget {
  const City_listing_screen({Key? key}) : super(key: key);

  @override
  State<City_listing_screen> createState() => _City_listing_screenState();
}

class _City_listing_screenState extends State<City_listing_screen> {
  final controller = Get.put(City_Controller());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit location'),
        ),
        body:SingleChildScrollView(child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  GetBuilder<City_Controller>(
                    // no need to initialize Controller ever again, just mention the type
                      builder: (value) =>  InkWell(
                      onTap: () async {
                        web.Prediction? p =
                            await google.PlacesAutocomplete.show(
                                radius: 100000,
                                strictbounds: false,
                                types: [],
                                context: context,
                                apiKey: kGoogleApiKey,
                                logo: Text(""),
                                mode: google.Mode.overlay,
                                // Mode.fullscreen
                                language: "en",
                                components: [
                                  new web.Component(
                                    web.Component.country,
                                    "usa",
                                  ),
                                  new web.Component(
                                      web.Component.country, "ae"),
                                  new web.Component(
                                      web.Component.country, "pk"),
                                  new web.Component(
                                      web.Component.country, "IN"),
                                  new web.Component(
                                      web.Component.country, "us"),
                                ]);
                        if (p!.placeId == null) {
                          print('null data is coming');
                        } else {
                          List<Location> locations =
                              await locationFromAddress(p!.description!);
                          final lat = locations[0].latitude;
                          final long = locations[0].longitude;
                          final data=City_Model(
                            city_name: p!.description,
                            long: lat,
                            lat: long,
                          );
                       setState(() {
                         //controller.city_model_list.value.add(data);

                         if(value.list_current_weather.length+1<=7) {
                           setState(() {
                             value.bindind(lat, long);
                             print('please  max ${value.list_current_weather
                                 .length}');
                           });

                         }



                         });
                         print('list data is   ${ controller.city_model_list.value}');
                        }
                      },
                      child: Container(
                          padding:const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black45,
                            size: 30,
                          )))),
                  Container(
                      padding:const EdgeInsets.all(10),
                      child:const Text(
                        'Add location',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: width,
              child: const Divider(color: Colors.grey),
            ),
           const SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              height: 60,
              color: Colors.black45,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child:const Text('my location',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start),
              ),
            ),
          const  SizedBox(
              height: 10,
            ),
            GetBuilder<City_Controller>(
              // no need to initialize Controller ever again, just mention the type
                builder: (value) => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.list_current_weather.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                        child: Text(
                                          value.list_current_weather[index].name!,
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 13),
                                    )),
                                    InkWell(
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                      onTap: () {
                                       // value.deletecity(value.city[index].id!);
                                        value.remove_list(index);
                                      },
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: width,
                              child: Divider(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }))
          ],
        )));
  }
}
