import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/enrolled_studentlist.dart';
import 'package:project_lily/educator_screen/manage_courses_detail.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/screens/course_description.dart';
import '../component/AddCourseLesson.dart';
import '../component/ContactCard.dart';
import '../component/NavigationBar.dart';
import '../component/searchBar.dart';
import '../helperMethods/DbHelper.dart';

class Students extends StatefulWidget {
  static const String id = 'students';

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<Students> {
  DbHelper dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: dbHelper.getAllCoursesFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Container(
                color: backgroundColor,
                child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                    'Students',
                    style: appLabelTextStyle.copyWith(fontSize: 30),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  searchBar(),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Student by courses',
                    style: appLabelTextStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  Flexible(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      // Number of items in the list
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        // Generate a widget for each item in the list
                        return Column(
                          children: [
                            CourseAvailable(
                              imagePath:
                              snapshot.data![index].thumbnailUrl,
                              courseName:
                              snapshot.data![index].courseTitle,
                              coursePath: EnrolledStudentList.id,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // CourseAvailable(
                  //   imagePath: 'images/sex_education.png',
                  //   courseName: 'Sex Education',
                  //   coursePath: EnrolledStudentList.id,
                  // ),
                  // SizedBox(height: 15,),
                  // CourseAvailable(
                  //   imagePath: 'images/sex_education.png',
                  //   courseName: 'Sex Education',
                  //   coursePath: EnrolledStudentList.id,
                  // ),
                  // SizedBox(height: 15,),
                  // CourseAvailable(
                  //   imagePath: 'images/sex_education.png',
                  //   courseName: 'Sex Education',
                  //   coursePath: EnrolledStudentList.id,

                ],
                              )),
                            ),
            );
            }
          }),


      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}

