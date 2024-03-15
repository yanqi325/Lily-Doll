import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/profile_page.dart';
import 'package:project_lily/screens/squeezes.dart';
import 'package:project_lily/screens/touches.dart';
import '../Data/Courses.dart';
import '../component/AppBar.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';

class DataReport extends StatefulWidget {
  static const String id = 'data_report';

  @override
  _DataReportScreenState createState() => _DataReportScreenState();
}

class _DataReportScreenState extends State<DataReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Data Report',
        icon: null,), //Courses.label
      ),
      body: Container(
        color: backgroundColor2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'We help to analyse the Anxiety Squeeze of you and Most Frequent Touch part of the Lily Doll.',
                style: appLabelTextStyle.copyWith(color: purple6),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Which one would you like to analyse?',
                style: appLabelTextStyle.copyWith(color: purple4, fontSize: 24),
              ),
              SizedBox(
                height: 18,
              ),
              elevatedButton(
                icon: Icons.touch_app_sharp,
                title: 'Touches',
                fontSize: 20,
                fontColor: Colors.black,
                height: 70,
                color: backgroundColor,
                onPressed: () {
                  Navigator.pushNamed(context, Touches.id);
                },
              ),
              SizedBox(
                height: 10,
              ),
              elevatedButton(
                icon: Icons.front_hand_sharp,
                title: 'Squeezes',
                fontSize: 20,
                fontColor: Colors.black,
                height: 70,
                color: backgroundColor,
                onPressed: () {
                  Navigator.pushNamed(context, Squeezes.id);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(initialIndex: 0,),
    );
  }
}
