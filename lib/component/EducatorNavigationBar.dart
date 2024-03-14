import 'package:flutter/material.dart';
import 'package:project_lily/educator_screen/dashboard.dart';
import 'package:project_lily/educator_screen/manage_courses.dart';
import 'package:project_lily/educator_screen/students.dart';
import 'package:project_lily/screens/courses_page.dart';
import 'package:project_lily/screens/data_report.dart';
import 'package:project_lily/screens/home_page.dart';
import 'package:project_lily/screens/welcome_screen.dart';

import '../constants.dart';
import '../screens/chat.dart';

class EducatorNavigationBar extends StatefulWidget {
  //final int? initialIndex;
  EducatorNavigationBar({ super.key});

  @override
  _EducatorNavigationBarState createState() => _EducatorNavigationBarState();
}

class _EducatorNavigationBarState extends State<EducatorNavigationBar> {
  int _currentInd = 0;

  @override
  void initState() {
    super.initState();
    // Set the initial index here
    _currentInd = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 8),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentInd,
          type: BottomNavigationBarType.fixed,
          backgroundColor: purple5,
          unselectedItemColor: purple4,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, size: 30),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Messages',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentInd = index;
            });

            switch (index) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),);
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageCourses()),);
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => Students()),);
                break;
              case 3:
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()),);
                break;
              default:
              // Handle other cases if needed
            }
          },
        ),
      ),
    );
  }
}

