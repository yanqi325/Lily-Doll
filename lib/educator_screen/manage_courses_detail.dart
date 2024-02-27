import 'package:flutter/material.dart';
import 'package:project_lily/component/AddAttachment.dart';
import 'package:project_lily/component/AddCourseLesson.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/component/ManageLessonCard.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/screens/course_description.dart';
import '../component/AppBar.dart';
import '../component/ContactCard.dart';
import '../component/NavigationBar.dart';
import '../component/searchBar.dart';
import 'add_lesson.dart';

class ManageCoursesDetail extends StatefulWidget {
  static const String id = 'manage_courses_detail';

  @override
  _ManageCoursesDetailScreenState createState() => _ManageCoursesDetailScreenState();
}

class _ManageCoursesDetailScreenState extends State<ManageCoursesDetail> {

  List<String?> statuses = ['Locked', 'Locked', 'Locked']; // Initial statuses for each lesson, get from firebase?

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    print("At manage course details: " + args["courseTitle"]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Sex Education'), //Courses.label
      ),
      body: Container(
        color: backgroundColor2,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('XX students enrolled in this course', style: appLabelTextStyle.copyWith(color: Colors.grey, fontSize: 15),),
              AddButton(title: 'Add Lesson', path: AddLesson.id,courseName:args["courseTitle"]),
              SizedBox(height: 15,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ManageLessonCard(
                        courseName: 'Lesson ${index + 1}',
                        imagePath: 'images/sex_lesson1.png',
                        status: statuses[index],
                        onValueChanged: (value) {
                          setState(() {
                            statuses[index] = value;
                          });
                        },
                      ),
                      SizedBox(height: 10), // Add a SizedBox after each ManageLessonCard
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
