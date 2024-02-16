import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/AppBar.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';
import '../component/TouchesPart.dart';

class Touches extends StatefulWidget {
  static const String id = 'touches';

  @override
  _TouchesScreenState createState() => _TouchesScreenState();
}

class _TouchesScreenState extends State<Touches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Touches'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Center(
                  child: Container(
                    child: Image.asset('images/lilydoll2.png', scale: 1.8,),
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location',style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 25),),
                        Text('Most touched areas',style: appLabelTextStyle.copyWith(fontSize: 14),),
                        SizedBox(height: 12,),
                        TouchesPart(label: 'Head',color: Colors.blue,),
                        SizedBox(height: 10,),
                        TouchesPart(label: 'Chest',color: Colors.orangeAccent,),
                        SizedBox(height: 10,),
                        TouchesPart(label: 'Crotch', color: purple5,),
                        SizedBox(height: 10,),
                        TouchesPart(label: 'Behind', color: purple4,),

                      ],

                     ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

