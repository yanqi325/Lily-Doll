import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/add_lesson.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';

class CourseDescription extends StatefulWidget {
  static const String id = 'courses_description';
  String courseTitle = '';
  String descText = '';
  int numOfStudents = 0;
  String imagePath = '';
  String altText = "You are not enrolled in this course!";
  bool isEnrolled= false;
  bool isEducatorMode = false;
  bool isOnlineAsset = false;

  CourseDescription(
      {required this.courseTitle,
      required this.descText,
      required this.numOfStudents,
      required this.imagePath,
      required this.altText,
      required this.isEnrolled,
      required this.isEducatorMode,
      required this.isOnlineAsset});

  @override
  _CoursesDescriptionScreenState createState() =>
      _CoursesDescriptionScreenState();
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
                child: !widget.isOnlineAsset ? Image.asset(
                  widget.imagePath,
                  scale: 1.2,
                ) : Image.network(
                  widget.imagePath!,
                  width: 56,
                  height: 56,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Error occurred while loading the image, display default image instead
                    return Image.asset("images/puzzle.png",width: 56,height: 56,);
                  },
                ) //extract from courses class
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseTitle,
                      style: appLabelTextStyle.copyWith(fontSize: 26),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.descText,
                        textAlign: TextAlign.justify,
                        style: appLabelTextStyle.copyWith(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '${widget.numOfStudents} Students enrolled this course',
                        style: appLabelTextStyle.copyWith(
                            fontSize: 11, color: Colors.grey)),
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: elevatedButton(
                        title: 'Proceed',
                        fontColor: Colors.black,
                        width: 110,
                        height: 38,
                        //disable button
                        onPressed: widget.isEnrolled ? () {
                          if(widget.isEducatorMode){
//go to add lesson page
                            Navigator.pushNamed(context, AddLesson.id, arguments: {"courseTitle" : widget.courseTitle});
                          }else{
                            Navigator.pushNamed(context, CoursesChapter.id,arguments: {"courseTitle" : widget.courseTitle});
                          }
                        }: null,
                        color: backgroundColor,
                      ),
                    ),
                    Center(child: !widget.isEnrolled == true ? Text(widget.altText) : Text("")
                     ,)
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
