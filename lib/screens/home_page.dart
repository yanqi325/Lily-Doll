import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/BluetoothService.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_lily/screens/profile_page.dart';
import 'package:project_lily/screens/setting_page.dart';

import '../Data/Users.dart';
import '../component/NavigationBar.dart';
import '../component/ToggleButton.dart';
import '../helperMethods/AuthHelper.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  double? battPercent = 1.0; //get from the doll
  bool isSwitched = false;



  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper = new AuthHelper();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100), // Adjust the height as needed
          child: FutureBuilder<String?>(
            future: authHelper.getCurrentUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  String? userName = snapshot.data;
                  return AppBar(
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
                              userName!,
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SettingPage(bleService: bleService,)),
                          //   );

                        },
                      ),
                    ],
                  );
                }
              }

              return Container(); // Placeholder widget
            },
          ),
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/bunny.png',
                              width: 400,
                              height: 500,
                            ),
                          ),
                          SizedBox(height: 40,),
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
                                width: 120.0,
                                lineHeight: 13.0,
                                percent: battPercent!,
                                backgroundColor: Colors.grey,
                                progressColor: Colors.lightGreenAccent,
                                barRadius: Radius.circular(12),
                              ),
                              Text( (battPercent!*100).toInt().toString() + '%',
                              style: appBarLabel.copyWith(color: purple4, fontSize: 12),),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Bluetooth',
                          //       textAlign: TextAlign.left,
                          //       style: appLabelTextStyle,
                          //     ),
                          //     SizedBox(
                          //       width: 40,
                          //     ),
                          //     ToggleButton(isSwitched: isSwitched),
                          //   ],
                          // )
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