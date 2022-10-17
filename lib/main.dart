import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Screen/Landing_Screen.dart';
import 'View/Screen/Splash_Screen.dart';
import 'View/Screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(

        //primarySwatch: Colors.black54,
      ),
      home: const Splash_screen(),
    );
  }
}


