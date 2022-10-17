import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:loop_page_view/loop_page_view.dart';
import '../../Controller/City_Controller.dart';

import 'City_listing_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final city_controller = Get.put(City_Controller());

  GlobalKey<FormState> _abcKey = GlobalKey<FormState>();
  double _current = 0;
  final CarouselController _controller = CarouselController();
  final LoopPageController controller = LoopPageController();





  @override
  Widget build(BuildContext context) {


    //  city_controller .bindind_local_data_with_api_listing();
    String cityName = "Katowice"; //city name
    //  int currTemp = 30; // current temperature
    int maxTemp = 30; // today max temperature
    int minTemp = 2; // today min temperature
    Size size = MediaQuery.of(context).size;
    //city_controller.dilog();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black54,
                      Colors.black87,
                    ],
                  )
              ),

              child: Container(
                alignment: Alignment.center,
                child: Text('Weather Application',style: TextStyle(color: Colors.white,fontSize: 16),),),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Manage Location'),
              onTap: () {
                Get.to(() => City_listing_screen());
              },
            ),

          ],
        ),
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              key: _abcKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: FaIcon(
                            FontAwesomeIcons.bars,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          onTap: () {
                            _key.currentState!.openDrawer();
                          },
                        ),
                        Align(
                          child: Text(
                            'Weather App', //TODO: change app name
                            style: GoogleFonts.questrial(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      Text('')
                      ],
                    ),
                  ),
                  GetBuilder<City_Controller>(
                      // no need to initialize Controller ever again, just mention the type
                      builder: (value) => Container(
                        alignment: Alignment.center,
                        child: DotsIndicator(
                          dotsCount: value.list_current_weather.length+1,
                          position: _current,
                          decorator: DotsDecorator(
                            color: Colors.white, // Inactive color
                            activeColor: Colors.redAccent,
                          ),
                        )
                      )),
                  GetBuilder<City_Controller>(
                      // no need to initialize Controller ever again, just mention the type
                      builder: (value) => Container(
                            height: size.height,
                            child: LoopPageView.builder(
                                controller: controller,
                                itemCount:
                                    city_controller.list_current_weather.length+1,
                                onPageChanged: (index) {
                                  setState(() {
                                    _current = index.toDouble();
                                    print(index);
                                    print(index);
                                  });
                                },
                                itemBuilder: (_, i) {
                                  //  city_controller.current_weather!.clear();
                                  // city_controller.api_status.value=false;

                                    return  i==city_controller.list_current_weather.length? value.status_api_five_days?Container(
                                        width: size.width / 1,
                                        child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: size.height * 0.03,
                                                  ),
                                                  child: Align(
                                                    child: Text(

                                                      value.current_five_days_m!.city!.name!,
                                                      style: GoogleFonts.questrial(
                                                        color: isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                        size.height * 0.06,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: size.height * 0.005,
                                                  ),
                                                  child: Align(
                                                    child: Text(
                                                      'Today', //day
                                                      style: GoogleFonts.questrial(
                                                        color: isDarkMode
                                                            ? Colors.white54
                                                            : Colors.black54,
                                                        fontSize:
                                                        size.height * 0.035,
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: size.width * 0.05,
                                                    vertical: size.height * 0.02,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      color: Colors.white
                                                          .withOpacity(0.05),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                          Alignment.centerLeft,
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                              top: size.height *
                                                                  0.02,
                                                              left:
                                                              size.width * 0.03,
                                                            ),
                                                            child: Text(
                                                              '5-day forecast',
                                                              style: GoogleFonts
                                                                  .questrial(
                                                                color: isDarkMode
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                fontSize:
                                                                size.height *
                                                                    0.025,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                     ListView.builder(
                                                         physics: NeverScrollableScrollPhysics(),
                                                         itemCount: value.current_five_days_m!.listW!.length,
                                                         shrinkWrap: true,

                                                         itemBuilder: (context,index){
                                                          // String formatDate(DateTime date) => new DateFormat("MMMM d").format(date);
                                                          final datee=  DateTime.parse(value.current_five_days_m!.listW![index].dtTxt!);
                                                       return Container(
                                                         child: Padding(
                                                           padding: EdgeInsets.all(
                                                               size.width * 0.005),
                                                           child: Column(
                                                             children: [
                                                               //TODO: change weather forecast from local to api get
                                                               buildSevenDayForecast(
                                                                 '${DateFormat.yMMMMd().format(datee) }', //day
                                                                 value.current_five_days_m!.listW![index].main!.tempMin.toString(),
                                                                 //min temperature
                                                                 value.current_five_days_m!.listW![index].main!.tempMax.toString(),
                                                                 //max temperature

                                                                 //weather icon
                                                                 size,
                                                                 isDarkMode,
                                                               ),







                                                             ],
                                                           ),
                                                         ),
                                                       );
                                                     })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))):Container(child:SpinKitDoubleBounce(color: Colors.white),):
                                   //city base list


                                    Container(
                                        width: size.width / 1,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: size.height * 0.03,
                                              ),
                                              child: Align(
                                                child: Text(
                                                  value.list_current_weather[i]
                                                      .name
                                                      .toString()!,
                                                  style: GoogleFonts.questrial(
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize:
                                                        size.height * 0.06,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: size.height * 0.005,
                                              ),
                                              child: Align(
                                                child: Text(
                                                  'Today', //day
                                                  style: GoogleFonts.questrial(
                                                    color: isDarkMode
                                                        ? Colors.white54
                                                        : Colors.black54,
                                                    fontSize:
                                                        size.height * 0.035,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: size.height * 0.03,
                                              ),
                                              child: Align(
                                                child: Text(
                                                  '${value.list_current_weather![i]!.main!.temp}˚C',
                                                  //curent temperature
                                                  style: GoogleFonts.questrial(
                                                    color: Colors.pink,
                                                    fontSize:
                                                        size.height * 0.13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.25),
                                              child: Divider(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: size.height * 0.005,
                                              ),
                                              child: Align(
                                                child: Text(
                                                  value.list_current_weather![i]
                                                      .weather![0].description!,
                                                  // weather
                                                  style: GoogleFonts.questrial(
                                                    color: isDarkMode
                                                        ? Colors.white54
                                                        : Colors.black54,
                                                    fontSize:
                                                        size.height * 0.03,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  top: size.height * 0.03,
                                                  bottom: size.height * 0.01,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'min',
                                                          // min temperature
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: minTemp <= 0
                                                                ? Colors.blue
                                                                : minTemp > 0 &&
                                                                        minTemp <=
                                                                            15
                                                                    ? Colors
                                                                        .indigo
                                                                    : minTemp > 15 &&
                                                                            minTemp <
                                                                                30
                                                                        ? Colors
                                                                            .deepPurple
                                                                        : Colors
                                                                            .pink,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                        Text(
                                                          '/',
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: isDarkMode
                                                                ? Colors.white54
                                                                : Colors
                                                                    .black54,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                        Text(
                                                          'max',
                                                          //max temperature
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: maxTemp <= 0
                                                                ? Colors.blue
                                                                : maxTemp > 0 &&
                                                                        maxTemp <=
                                                                            15
                                                                    ? Colors
                                                                        .indigo
                                                                    : maxTemp > 15 &&
                                                                            maxTemp <
                                                                                30
                                                                        ? Colors
                                                                            .deepPurple
                                                                        : Colors
                                                                            .pink,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${value.list_current_weather![i].main!.tempMin}˚C',
                                                          // min temperature
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: minTemp <= 0
                                                                ? Colors.blue
                                                                : minTemp > 0 &&
                                                                        minTemp <=
                                                                            15
                                                                    ? Colors
                                                                        .indigo
                                                                    : minTemp > 15 &&
                                                                            minTemp <
                                                                                30
                                                                        ? Colors
                                                                            .deepPurple
                                                                        : Colors
                                                                            .pink,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                        Text(
                                                          '/',
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: isDarkMode
                                                                ? Colors.white54
                                                                : Colors
                                                                    .black54,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${value.list_current_weather![i].main!.tempMax}˚C',
                                                          //max temperature
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: maxTemp <= 0
                                                                ? Colors.blue
                                                                : maxTemp > 0 &&
                                                                        maxTemp <=
                                                                            15
                                                                    ? Colors
                                                                        .indigo
                                                                    : maxTemp > 15 &&
                                                                            maxTemp <
                                                                                30
                                                                        ? Colors
                                                                            .deepPurple
                                                                        : Colors
                                                                            .pink,
                                                            fontSize:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.05,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: isDarkMode
                                                      ? Colors.white
                                                          .withOpacity(0.05)
                                                      : Colors.black
                                                          .withOpacity(0.05),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: size.height *
                                                              0.01,
                                                          left:
                                                              size.width * 0.03,
                                                        ),
                                                        child: Text(
                                                          'wind for today',
                                                          style: GoogleFonts
                                                              .questrial(
                                                            color: isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize:
                                                                size.height *
                                                                    0.025,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text(
                                                      value.list_current_weather![i].wind!.speed.toString(),
                                                      style: GoogleFonts.questrial(
                                                        color: isDarkMode ? Colors.white : Colors.black,
                                                        fontSize: size.height * 0.02,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        )));

                                }),
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForecastToday(String time, int temp, int wind, int rainChance,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            time,
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$temp˚C',
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.025,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.wind,
                  color: Colors.grey,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$wind km/h',
            style: GoogleFonts.questrial(
              color: Colors.grey,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.umbrella,
                  color: Colors.blue,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$rainChance %',
            style: GoogleFonts.questrial(
              color: Colors.blue,
              fontSize: size.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSevenDayForecast(String time, String minTemp, String maxTemp,
    size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(
        size.height * 0.005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  '${time} ',
                  style: GoogleFonts.questrial(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.28,
                ),

              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.20,
                  ),
                  child: Text(
                    '$minTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Text(
                    '$maxTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
   // checkGps();

setState(() {

});
    super.initState();
  }
}
