import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_lily/screens/about_us.dart';
import 'package:project_lily/screens/bluetooth.dart';
import 'package:project_lily/screens/help_center.dart';
import 'package:project_lily/screens/language.dart';
import 'package:project_lily/screens/notification.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../component/Cardboard.dart';
import '../component/NavigationBar.dart';
import '../helperMethods/AuthHelper.dart';

class SettingPage extends StatefulWidget {
  static const String id = 'setting_page';
  @override
  _SettingPageScreenState createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper = new AuthHelper();


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85), // Set the preferred height
        child: appBar(title: 'Settings',
        icon: null,),
      ),
      body: FutureBuilder<String?>(
        future: authHelper.getCurrentUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              String? userName = snapshot.data;
              return Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account',
                        style: appBarLabel.copyWith(
                            color: purple4, fontSize: 22),),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10,),
                            Avatar(radius: 40,),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Text(
                                  userName!,
                                  style: appBarLabel.copyWith(
                                      fontSize: 22, color: Colors.black),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'LilyDoll123',
                                  style: appBarLabel.copyWith(
                                      fontSize: 12, color: purple4),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: IconButton(
                                icon: Icon(Icons.bluetooth_rounded,
                                    size: 40,
                                    color: isPressed
                                        ? Colors.lightGreenAccent
                                        : Colors.black87),
                                // Use Icon(Icons.bluetooth) directly
                                onPressed: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                  if (isPressed == true) {
                                    Navigator.pushNamed(
                                        context, BluetoothPage.id);
                                  }
                                },
                              ),
                            ),
                          ],

                        ),
                      ),
                      SizedBox(height: 18,),
                      Text('Settings',
                        style: appBarLabel.copyWith(
                            color: purple4, fontSize: 22),
                      ),
                      SizedBox(height: 10,),
                      elevatedButton(
                        title: 'Notifications',
                        fontColor: Colors.black,
                        fontSize: 18,
                        color: backgroundColor,
                        elevation: 0,
                        icon: Icons.notifications,
                        width: 400,
                        align: MainAxisAlignment.start,
                        onPressed: () {
                          Navigator.pushNamed(context, NotificationPage.id);
                        },
                      ),
                      SizedBox(height: 10,),
                      elevatedButton(
                        title: 'Language',
                        fontColor: Colors.black,
                        fontSize: 18,
                        color: backgroundColor,
                        elevation: 0,
                        icon: Icons.language,
                        width: 400,
                        align: MainAxisAlignment.start,
                        onPressed: () {
                          Navigator.pushNamed(context, LanguagePage.id);
                        },
                      ),
                      SizedBox(height: 10,),
                      elevatedButton(
                        title: 'Help Center',
                        fontColor: Colors.black,
                        fontSize: 18,
                        color: backgroundColor,
                        elevation: 0,
                        icon: Icons.help_center_rounded,
                        width: 400,
                        align: MainAxisAlignment.start,
                        onPressed: () {
                          Navigator.pushNamed(context, HelpCenter.id);
                        },
                      ),
                      SizedBox(height: 10,),
                      elevatedButton(
                        title: 'About Us',
                        fontColor: Colors.black,
                        fontSize: 18,
                        color: backgroundColor,
                        elevation: 0,
                        icon: Icons.info,
                        width: 400,
                        align: MainAxisAlignment.start,
                        onPressed: () {
                          Navigator.pushNamed(context, AboutUs.id);
                        },
                      ),
                      SizedBox(height: 10,),
                      elevatedButton(
                        title: 'Account',
                        fontColor: Colors.black,
                        fontSize: 18,
                        color: backgroundColor,
                        elevation: 0,
                        icon: Icons.account_circle_sharp,
                        width: 400,
                        align: MainAxisAlignment.start,
                        onPressed: () {
                          Navigator.pushNamed(context, ProfilePage.id);
                        },
                      ),


                    ],
                  ),
                ),
              );
        }
        }
          return Container();
        },
      )


    );
  }
}



