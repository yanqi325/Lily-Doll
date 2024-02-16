import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/AppBar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_video.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/LessonCard.dart';
import '../component/NavigationBar.dart';

class CoursesChapter extends StatefulWidget {
  static const String id = 'courses_chapter';

  @override
  _CoursesChapterScreenState createState() => _CoursesChapterScreenState();
}

class _CoursesChapterScreenState extends State<CoursesChapter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Sex Education'),  //Courses.label
      ),
      body: Container(
        color: backgroundColor2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              LessonCard(onPressedContinue: () {Navigator.pushNamed(context, CourseVideo.id);}),
              LessonCard(),
              LessonCard(),
            ],
          ),
        ),
      ),
    );
  }
}

