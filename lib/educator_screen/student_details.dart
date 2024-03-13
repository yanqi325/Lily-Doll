import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/AuthHelper.dart';
import '../Data/Users.dart';
import '../component/AddAttachment.dart';
import '../component/CourseProgressionCard.dart';
import '../component/EducatorTextField.dart';
import '../component/UploadAddButton.dart';
import '../helperMethods/DbHelper.dart';

class StudentDetails extends StatefulWidget {
  static const String id = 'student_details';
  String courseTitle="";
  String userName="";




  StudentDetails({
    required this.courseTitle,
    required this.userName
});

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetails> {

  AuthHelper authHelper = new AuthHelper();
  DbHelper dbHelper = new DbHelper();
  String userId=''; // Declare a variable to store the user ID
  double progress = 0;

  void getCurrentUserId() async {
    String? id = await dbHelper.getUsernamesFromUsersExtended(widget.userName);
    setState(() {
      userId = id; // Update the user ID variable
      print("Set user id as" + userId!);
    });
  }
  @override
  void initState() {
    super.initState();
    getCurrentUserId(); // Call method to get current user's ID when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {

    // final Map<String, dynamic> args =
    // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

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
                      widget.userName,
                      style: appLabelTextStyle.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 20,),
                    Text('Course Details',
                      style: appLabelTextStyle.copyWith(color: purple7),
                    ),
                    //dynamically create based on future builder

        FutureBuilder<List<Map<String, dynamic>>>(
          future: dbHelper.getEnrolledCoursesProgress(userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final coursesProgress = snapshot.data ?? [];
              for (Map<String,dynamic> course in coursesProgress){
                if(course["courseTitle"] == widget.courseTitle){
                  progress = double.parse(course["progress"]);
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18,),
                  CourseProgressionCard(courseName: widget.courseTitle,coursePercent: progress),
                  SizedBox(height: 20,),
                  Text('Other Courses',
                    style: appLabelTextStyle.copyWith(color: purple7),
                  ),
                  SizedBox(height: 18,),
                  ...List.generate(coursesProgress.length, (index) {
                    final courseTitle = coursesProgress[index]['courseTitle'];
                    if (courseTitle != widget.courseTitle) { //If courseTitle is current courseTitle then skip creating the widget
                      return Column(
                        children: [
                          CourseProgressionCard(
                            courseName: courseTitle,
                            coursePercent: double.parse(coursesProgress[index]['progress']),
                          ),
                          SizedBox(height: 18), // SizedBox between each CourseProgressionCard
                        ],
                      );
                    } else {
                      return SizedBox(); // Skip creating the widget if the value should be filtered out
                    }
                  }),
                ],
              );

            }
          },
                    // SizedBox(height: 18,),
                    // CourseProgressionCard(courseName: 'Daily Life',coursePercent: 0.3,)


        )],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



