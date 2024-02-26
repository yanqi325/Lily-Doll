import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';

class CourseDescription extends StatefulWidget {
  static const String id = 'courses_description';

  @override
  _CoursesDescriptionScreenState createState() => _CoursesDescriptionScreenState();
}

class _CoursesDescriptionScreenState extends State<CourseDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageLabel(),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, top: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Image.asset('images/sex_education.png',scale: 1.2,), //extract from courses class
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sex Education',
                      style: appLabelTextStyle.copyWith(fontSize: 26),
                    ),
                    SizedBox(height: 10,),
                    Text("Random text to replace here",
                        textAlign: TextAlign.justify,
                        style: appLabelTextStyle.copyWith(fontSize: 15)
                    ),
                    SizedBox(height: 10,),
                    Text('XX Students enrolled this course',
                        style: appLabelTextStyle.copyWith(fontSize: 11, color: Colors.grey )
                    ),
                    SizedBox(height: 80,),
                    Center(
                      child: elevatedButton(
                        title: 'Enroll',
                        fontColor: Colors.black,
                        width: 110,
                        height: 38,
                        onPressed: (){
                          Navigator.pushNamed(context, CoursesChapter.id);
                        },
                        color: backgroundColor,),
                    ),
                  ],
                ),
              ),
            ), //extract from courses class
          ],
        ),

      ),
    );
  }
}

