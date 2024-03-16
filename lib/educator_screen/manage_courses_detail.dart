import 'package:flutter/material.dart';
import 'package:project_lily/component/AddAttachment.dart';
import 'package:project_lily/component/AddCourseLesson.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/component/ManageLessonCard.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/lessonVideoYT.dart';
import '../Data/Courses.dart';
import '../Data/Lessons.dart';
import '../component/AppBar.dart';
import '../component/ContactCard.dart';
import '../component/NavigationBar.dart';
import '../component/searchBar.dart';
import '../screens/course_video.dart';
import 'add_lesson.dart';

class ManageCoursesDetail extends StatefulWidget {
  static const String id = 'manage_courses_detail';

  @override
  _ManageCoursesDetailScreenState createState() =>
      _ManageCoursesDetailScreenState();
}

class _ManageCoursesDetailScreenState extends State<ManageCoursesDetail> {
  List<String?> statuses = [
    'Locked',
    'Locked',
    'Locked'
  ]; // Initial statuses for each lesson, get from firebase?
  DbHelper dbHelper = new DbHelper();
  String courseTitle = '';

  late Future<List<Lessons>> _futureData;
  late Future<List<String>> _futureUsernames;

  //callback for widget
  void _refreshPageAfterWidgetAction() {
    print("called calllback");
    setState(() {
      Future.delayed(new Duration(seconds: 2));
      _futureData = dbHelper.getALlLessonsOfCourse(courseTitle);
    });
    print("SDF");
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Initial call to fetch data
  //
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    _futureData = dbHelper.getALlLessonsOfCourse(args["courseTitle"]);
    courseTitle = args['courseTitle'];

    _futureUsernames = dbHelper.getAllUsernames();

    print("At manage course details: " + args["courseTitle"]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(
          title: args["courseTitle"],
          icon: null,
        ), //Courses.label
      ),
      body: FutureBuilder(
          future: Future.wait([_futureData, _futureUsernames]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Container(
                color: backgroundColor2,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '45 students enrolled in this course',
                        style: appLabelTextStyle.copyWith(
                            color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AddButton(
                        title: 'Add Lesson',
                        path: AddLesson.id,
                        courseName: args["courseTitle"],
                        isCourse: false,
                        isEnroll: false,
                        isModify: false,
                        refreshPage: _refreshPageAfterWidgetAction,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data![0].length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ManageLessonCard(
                                    courseNameFull: 'Lesson ${index + 1}: ' +
                                        snapshot.data![0][index].lessonTitle,
                                    changeValueCallback:_refreshPageAfterWidgetAction,
                                    courseTitle: courseTitle,

                                    lessonTitle:
                                        snapshot.data![0][index].lessonTitle,
                                    imagePath: 'images/sex_lesson1.png',
                                    status: snapshot.data![0][index].isLocked
                                                .toString()
                                                .toLowerCase() ==
                                            "true"
                                        ? "Locked"
                                        : "Unlocked",
                                    coursePath: CourseVideo.id,
                                    popupItems: snapshot.data![1],
                                    videoPage: LessonVideoYT(
                                      isUser: false,
                                      lessonNo: (index + 1).toString(),
                                      lessonTitle:
                                          snapshot.data![0][index].lessonTitle,
                                      courseTitle: args["courseTitle"],


                                    ),
                                    onValueChanged: (value) {
                                      setState(() {
                                        // statuses[index] = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  // Add a SizedBox after each ManageLessonCard
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
