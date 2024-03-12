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
  _ManageCoursesDetailScreenState createState() => _ManageCoursesDetailScreenState();
}

class _ManageCoursesDetailScreenState extends State<ManageCoursesDetail> {

  List<String?> statuses = ['Locked', 'Locked', 'Locked']; // Initial statuses for each lesson, get from firebase?
  DbHelper dbHelper = new DbHelper();
  String courseTitle ='';


  late Future<List<Lessons>> _futureData;
  //callback for widget
  void _refreshPageAfterWidgetAction(){
    print("called calllback");
    setState(() {
      _futureData = dbHelper.getALlLessonsOfCourse(courseTitle);
    });
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

    print("At manage course details: " + args["courseTitle"]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: args["courseTitle"]), //Courses.label
      ),
      body:
      FutureBuilder(
          future: _futureData,
          builder: (context, snapshot) {
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
                      Text('45 students enrolled in this course', style: appLabelTextStyle.copyWith(color: Colors.grey, fontSize: 15),),
                      AddButton(title: 'Add Lesson', path: AddLesson.id,courseName:args["courseTitle"],isCourse: false,isEnroll: false,refreshPage: _refreshPageAfterWidgetAction,),
                      SizedBox(height: 15,),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ManageLessonCard(
                                courseName: 'Lesson ${index + 1}: ' + snapshot.data![index].lessonTitle,
                                imagePath: 'images/sex_lesson1.png',
                                status: snapshot.data![index].isLocked.toString().toLowerCase() == "islocked" ? "Locked" : "Unlocked",
                                coursePath: CourseVideo.id,
                                videoPage: LessonVideoYT(isUser: false,lessonNo:(index + 1).toString(),lessonTitle: snapshot.data![index].lessonTitle,courseTitle: args["courseTitle"],),
                                onValueChanged: (value) {
                                  setState(() {
                                    // statuses[index] = value;
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
              );
            }
          }),

    );
  }
}
