import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_lily/screens/profile_page.dart';
import 'package:project_lily/screens/setting_page.dart';

import '../Data/Users.dart';
import '../component/NavigationBar.dart';
import '../component/ToggleButton.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  double? battPercent = 0.7; //get from the doll
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: purple4,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Row(
            children: [
              Avatar(
                radius: 30,
                align: Alignment.topLeft,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: appBarLabel,
                  ),
                  Text(
                    Users.username,
                    style: appBarLabel.copyWith(fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              alignment: Alignment.topRight,
              color: Colors.white,
              icon: Icon(
                Icons.settings,
                size: 40,
              ),
              onPressed: () {
                Navigator.pushNamed(context, SettingPage.id);
              },
            ),
          ], // Set the title
        ),
        body: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage('images/wallpaper.png'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // Color of the shadow
                          spreadRadius: 1,
                          // Spread radius
                          blurRadius: 3,
                          // Blur radius
                          offset:
                          Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/bunny.png',
                              width: 300,
                              height: 340,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Battery Level',
                                textAlign: TextAlign.left,
                                style: appLabelTextStyle,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              LinearPercentIndicator(
                                width: 195.0,
                                lineHeight: 14.0,
                                percent: battPercent!,
                                backgroundColor: Colors.grey,
                                progressColor: Colors.lightGreenAccent,
                                barRadius: Radius.circular(12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Bluetooth',
                                textAlign: TextAlign.left,
                                style: appLabelTextStyle,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              ToggleButton(isSwitched: isSwitched),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(initialIndex: 0));
  }

}