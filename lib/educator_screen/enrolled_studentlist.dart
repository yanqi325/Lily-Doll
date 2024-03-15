import 'package:flutter/material.dart';
import 'package:project_lily/component/AddCourseLesson.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EnrolledStudentCard.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/enrollment.dart';
import 'package:project_lily/educator_screen/student_details.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../helperMethods/DbHelper.dart';
import 'add_lesson.dart';

class EnrolledStudentList extends StatefulWidget {
  static const String id = 'enrolled_student_list';

  @override
  _EnrolledStudentListScreenState createState() =>
      _EnrolledStudentListScreenState();
}

class _EnrolledStudentListScreenState extends State<EnrolledStudentList> {

  late Future<List<Map<String, dynamic>>> _futureData;
  String educatorId = "";
  String courseTitle = "";
  DbHelper dbHelper = new DbHelper();

  void _refreshPageAfterWidgetAction(){
    print("called calllback");
    setState(() {
      _futureData = dbHelper.getAllEnrolledUsers(
          educatorId, courseTitle);
    });
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    //initiatlize data first
    courseTitle = args['courseTitle'];
    educatorId = args["educatorId"];
    _futureData = dbHelper.getAllEnrolledUsers(
        educatorId, courseTitle);


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: courseTitle,
        icon: null,), //Courses.label
      ),
      body: Container(
        color: backgroundColor2,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final enrolledStudents = snapshot.data ?? [];
                      return Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              '${enrolledStudents.length} students enrolled this course',
                              style: appLabelTextStyle.copyWith(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            AddButton(
                              title: 'Enroll Student',
                              path: Enrollment.id,
                              isCourse: false,
                              isEnroll: true,
                              courseName: courseTitle,
                              refreshPage: _refreshPageAfterWidgetAction,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: enrolledStudents.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      EnrolledStudentCard(
                                        studentName: enrolledStudents[index]
                                            ['Username'],
                                        imagePath: "",
                                        path: StudentDetails.id,
                                        studentDetailsNewWidget: StudentDetails(courseTitle:args["courseTitle"],userName: enrolledStudents[index]
                                        ['Username']),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            // Build the list of enrolled student cards dynamically
                          ]));
                    }
                  })
              // Text('XX students enrolled this course', style: appLabelTextStyle.copyWith(color: Colors.grey, fontSize: 15),),
              // AddButton(title: 'Enroll Student',path: Enrollment.id,isCourse: true,isEnroll: true,courseName: args["courseTitle"]),
              // SizedBox(height: 15,),
              // EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
              // SizedBox(height: 10,),
              // EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
              // SizedBox(height: 10,),
              // EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
            ],
          ), //sdsd
        ),
      ),
    );
  }
}
