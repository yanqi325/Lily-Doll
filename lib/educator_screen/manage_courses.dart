import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/educator_screen/manage_courses_detail.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/constants.dart';
import '../Data/Courses.dart';
import '../component/AddCourseLesson.dart';
import '../component/searchBar.dart';

class ManageCourses extends StatefulWidget {
  static const String id = 'manage_courses';

  @override
  _ManageCoursesScreenState createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCourses> {

  late Future<List<Courses>> _futureData;
  DbHelper dbHelper = new DbHelper();
  void _refreshPageAfterWidgetAction(){
    print("called calllback");
    setState(() {
      _futureData = dbHelper.getAllCoursesFromFirestore();
    });
  }


  @override
  Widget build(BuildContext context) {
    _futureData = dbHelper.getAllCoursesFromFirestore();

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
                        SizedBox(
                          height: 12,
                        ),
                        AddButton(
                          title: 'Add Course',
                          path: UploadCourse.id,
                          isCourse: true,
                          isEnroll: false,
                          isModify: false,
                          refreshPage: _refreshPageAfterWidgetAction,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Courses Available',
                          style: appLabelTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Container(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CourseAvailable(
                                  imagePath: snapshot.data![index].thumbnailUrl,
                                  courseName: snapshot.data![index].courseTitle,
                                  coursePath: ManageCoursesDetail.id,
                                  refreshPageFromSecondWidget: _refreshPageAfterWidgetAction,
                                  icons: Icons.more_vert_rounded,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}
