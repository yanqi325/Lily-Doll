import 'package:flutter/material.dart';
import 'package:project_lily/component/AddCourseLesson.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EnrolledStudentCard.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/enrollment.dart';
import 'package:project_lily/educator_screen/student_details.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import 'add_lesson.dart';

class EnrolledStudentList extends StatefulWidget {
  static const String id = 'enrolled_student_list';

  @override
  _EnrolledStudentListScreenState createState() => _EnrolledStudentListScreenState();
}

class _EnrolledStudentListScreenState extends State<EnrolledStudentList> {


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

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
              Text('XX students enrolled this course', style: appLabelTextStyle.copyWith(color: Colors.grey, fontSize: 15),),
              AddButton(title: 'Enroll Student',path: Enrollment.id,isCourse: true,isEnroll: true,courseName: args["courseTitle"]),
              SizedBox(height: 15,),
              EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
              SizedBox(height: 10,),
              EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
              SizedBox(height: 10,),
              EnrolledStudentCard(studentName: Users.username, imagePath: 'images/profile.png',path: StudentDetails.id,),
            ],
          ),
        ),
      ),

    );
  }
}

