import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import '../Data/Users.dart';
import '../component/AddAttachment.dart';
import '../component/CourseProgressionCard.dart';
import '../component/EducatorTextField.dart';
import '../component/UploadAddButton.dart';

class StudentDetails extends StatefulWidget {
  static const String id = 'student_details';

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: purple4),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 40, // Adjust the radius according to your needs
                      backgroundImage: AssetImage('images/profile.png',), // retrieve from firebase?
                    ),
                    SizedBox(height: 8,),
                    Text(
                      Users.username,
                      style: appLabelTextStyle.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 20,),
                    Text('Course Details',
                      style: appLabelTextStyle.copyWith(color: purple7),
                    ),
                    SizedBox(height: 18,),
                    CourseProgressionCard(courseName: 'Sex Education',coursePercent: 0.6,),
                    SizedBox(height: 20,),
                    Text('Other Courses',
                      style: appLabelTextStyle.copyWith(color: purple7),
                    ),
                    SizedBox(height: 18,),
                    CourseProgressionCard(courseName: 'Daily Life',coursePercent: 0.3,)


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



