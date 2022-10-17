import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/constant_parameter.dart';
import 'City_listing_screen.dart';
class Landing_Screen extends StatefulWidget {
  const Landing_Screen({Key? key}) : super(key: key);

  @override
  State<Landing_Screen> createState() => _Landing_ScreenState();
}

class _Landing_ScreenState extends State<Landing_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          app_title,
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Manage Location'),
              onTap: () {
             Get.to(()=>City_listing_screen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(child: Column(
        children: [
Container(child: Text('wow tis screen is cool'),)
        ],
      ),),
    );
  }
}
