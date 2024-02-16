import 'package:easy_search_bar/easy_search_bar.dart';
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
import '../component/ContactCard.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';
import 'package:project_lily/constants.dart';

import '../component/searchBar.dart';

class Chat extends StatefulWidget {
  static const String id = 'data_report';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chat> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chats',
                    style: appLabelTextStyle.copyWith(fontSize: 40),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  searchBar(),
                ],
              )),
            ),
            Container(
              height: 455,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ContactCard(),
                      SizedBox(
                        height: 20,
                      ),
                      ContactCard(),
                      SizedBox(
                        height: 20,
                      ),
                      ContactCard(),
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        initialIndex: 0,
      ),
    );
  }
}
