import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/manage_courses_detail.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/screens/course_description.dart';
import '../component/AddCourseLesson.dart';
import '../component/ContactCard.dart';
import '../component/NavigationBar.dart';
import '../component/searchBar.dart';

class ManageCourses extends StatefulWidget {
  static const String id = 'manage_courses';

  @override
  _ManageCoursesScreenState createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCourses> {
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
                    'Manage Courses',
                    style: appLabelTextStyle.copyWith(fontSize: 30),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  searchBar(),
                  SizedBox(
                    height: 12,
                  ),
                  AddButton(title: 'Add Course', path: UploadCourse.id,),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Courses Available',
                    style: appLabelTextStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  //TODO: Replace this section with data from firebase
                  CourseAvailable(
                    imagePath: 'images/sex_education.png',
                    courseName: 'brawling',
                    coursePath: ManageCoursesDetail.id,
                  ),
                  SizedBox(height: 15,),
                  CourseAvailable(
                    imagePath: 'images/sex_education.png',
                    courseName: 'Sex Education',
                    coursePath: ManageCoursesDetail.id,
                  ),
                  SizedBox(height: 15,),
                  CourseAvailable(
                    imagePath: 'images/sex_education.png',
                    courseName: 'Sex Education',
                    coursePath: ManageCoursesDetail.id,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}

