import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';

class CoursesPage extends StatefulWidget {
  static const String id = 'courses_page';

  @override
  _CoursesPageScreenState createState() => _CoursesPageScreenState();
}

class _CoursesPageScreenState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(initialIndex: 0),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Users.username,
                    style: appLabelTextStyle.copyWith(fontSize: 28),
                  ),
                  Text(
                    'Welcome to our courses',
                    style: appLabelTextStyle.copyWith(color: purple6),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: purple4,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 120,
                    width: 400,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Users.level,
                                style: appLabelTextStyle.copyWith(
                                    color: Colors.white, fontSize: 28),
                              ),
                              Text(
                                'course',
                                style:
                                    appLabelTextStyle.copyWith(color: purple6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: [
                        iconButton(
                          label: 'Sex Education', //extract from Courses class?
                          image: 'images/sex_education.png', //extract from Courses class?
                          route: CourseDescription.id,
                        ), //add route
                        SizedBox(
                          width: 20,
                        ),
                        iconButton(
                            label: 'Daily Life',
                            image: 'images/daily_life.png'), //add route
                        SizedBox(
                          width: 20,
                        ),
                        iconButton(
                            label: 'Shape',
                            image: 'images/shape.png'), //add route
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Learn at Your Own Pace',
                    style: appLabelTextStyle.copyWith(fontSize: 22),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CoursesCard(),
                  SizedBox(
                    height: 15,
                  ),
                  CoursesCard(),
                ],
              ),
              Positioned(
                top: 8,
                right: -35,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('images/teacher.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

