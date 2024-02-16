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

class HelpCenter extends StatefulWidget {
  static const String id = 'help_center';
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenter> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Help Center'),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('[AIDA]: +6 012 345 6789',
              style: appBarLabel.copyWith(color: purple4 ,fontSize: 16),),
              SizedBox(height: 12,),
              elevatedButton(
                title: 'Call',
                fontColor: Colors.black,
                fontSize: 18,
                color: Colors.white,
                elevation: 1,
                icon: Icons.phone,
                width: 400,
                height: 75,
                align: MainAxisAlignment.start,
                onPressed: (){},
              ),
              elevatedButton(
                title: 'Message',
                fontColor: Colors.black,
                fontSize: 18,
                color: Colors.white,
                elevation: 1,
                icon: Icons.message_rounded,
                width: 400,
                height: 75,
                align: MainAxisAlignment.start,
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),


    );
  }

}

