import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../component/Cardboard.dart';
import '../component/NavigationBar.dart';
import '../component/ToggleButton.dart';
import '../component/ToggleButtonCard.dart';

class NotificationPage extends StatefulWidget {
  static const String id = 'notification_page';
  @override
  _NotificationPageScreenState createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Notifications'),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleButtonCard(label: 'Allow notifications',),
              SizedBox(height: 20,),
              Text('Notification settings',
                style: appBarLabel.copyWith(color: purple4, fontSize: 22),),
              SizedBox(height: 12,),
              ToggleButtonCard(label: 'Sounds',), //need set onChange
              ToggleButtonCard(label: 'Badge app icon',),
              ToggleButtonCard(label: 'Show on lock screen',),
            ],
          ),
        ),
      ),


    );
  }

}

