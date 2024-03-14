import 'package:flutter/material.dart';
import 'package:project_lily/screens/courses_page.dart';
import 'package:project_lily/screens/data_report.dart';
import 'package:project_lily/screens/home_page.dart';
import 'package:project_lily/screens/welcome_screen.dart';

import '../constants.dart';
import '../screens/chat.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int? initialIndex;
  BottomNavigationBarWidget({ this.initialIndex});

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  late int _currentInd;

  @override
  void initState() {
    super.initState();
    _currentInd = widget.initialIndex!;
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
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Report',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                  break;
                case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesPage()),);
                  break;
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DataReport()),);
                  break;
                case 3:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()),);
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
