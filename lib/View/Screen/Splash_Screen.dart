import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../utility/entrance_fader.dart';
import 'home_page.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {

  void _next() {

    Future.delayed(
      const Duration(seconds: 5),

          () {

           Get.off(()=>HomePage());
      },
    );
  }
  @override
  void initState() {
    _next();
    setState(() {

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: EntranceFader(
                  offset: const Offset(0, 30),
                  duration: const Duration(seconds: 2),
                  child: Text(
                    'Weather Application',
                    style:TextStyle(color: Colors.white,fontSize: 20)
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(child:SpinKitDoubleBounce(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }


}
