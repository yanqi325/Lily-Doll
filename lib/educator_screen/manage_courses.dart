import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/manage_courses_detail.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
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
                          AddButton(
                            title: 'Add Course',
                            path: UploadCourse.id,
                            isCourse: true,
                              isEnroll: true
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Courses Available',
                            style: appLabelTextStyle.copyWith(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
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
                                    coursePath: ManageCoursesDetail.id,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              );
                            },
                          ),

                          // CourseAvailable(
                          //   imagePath: 'images/sex_education.png',
                          //   courseName: 'Sex Education',
                          //   coursePath: ManageCoursesDetail.id,
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // CourseAvailable(
                          //   imagePath: 'images/sex_education.png',
                          //   courseName: 'Sex Education',
                          //   coursePath: ManageCoursesDetail.id,
                          // ),
                        ],
                      )),
                    ),
                  ],
                ),
              );
            }
          }),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}
