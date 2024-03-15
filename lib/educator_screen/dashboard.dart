import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/component/searchBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/AuthHelper.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/profile_page.dart';
import 'package:project_lily/screens/squeezes.dart';
import 'package:project_lily/screens/touches.dart';
import '../Data/Courses.dart';
import '../component/AppBar.dart';
import '../component/Avatar.dart';
import '../component/CoursesCard.dart';
import '../component/EducatorNavigationBar.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../component/PageLabel.dart';
import '../component/RecentCourses_educator.dart';
import '../component/ScheduleClass.dart';
import '../screens/course_description.dart';
import '../screens/setting_page.dart';
import 'manage_courses_detail.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';


  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: appBar_educator(), //Courses.label
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 450,
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: appLabelTextStyle.copyWith(
                      color: Colors.black, fontSize: 33),
                ),
                Text(
                  'Recent accessed courses',
                  style: appLabelTextStyle,
                ),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      RecentCourses_educator(
                        iconImage: 'images/sex_education.png',
                        courseTitle: 'Sex Education',
                        courseDescWidget: CourseDescription(
                          courseTitle: "Sex Education",
                          numOfStudents: 190,
                          descText:
                          "This is a course where students will learn about their rights of their body",
                          imagePath: 'images/sex_education.png',
                          altText: "",
                          isEnrolled: true,
                          isEducatorMode: true,
                          isOnlineAsset: false
                        )
                      ),
                      RecentCourses_educator(
                        iconImage: 'images/shape.png',
                        courseTitle: 'Shape',courseDescWidget:
                      CourseDescription(
                        courseTitle: "Shapes",
                        numOfStudents: 65,
                        descText:
                        "This is a course where students will learn about the different types of shapes",
                        imagePath: 'images/shape.png',
                        altText: "",
                        isEnrolled: true,
                        isEducatorMode: true,
                          isOnlineAsset: false
                      ),

                      ),
                      RecentCourses_educator(
                        iconImage: 'images/daily_life.png',
                        courseTitle: 'Daily Life',
                        courseDescWidget: CourseDescription(
                          courseTitle: "Daily Life",
                          numOfStudents: 3,
                          descText:
                          "This is a course where students will learn about the ins and outs of life",
                          imagePath: 'images/daily_life.png',
                          altText: "",
                          isEnrolled: true,
                          isEducatorMode: true,
                            isOnlineAsset: false
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Text(
                  'Today\'s classes',
                  style: appLabelTextStyle,
                ),
                SizedBox(height: 12,),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      ScheduleClass(colour: Colors.red, classTitle: 'Dancing', time: '1400 - 1500'),
                      SizedBox(height: 15,),
                      ScheduleClass(colour: Colors.red, classTitle: 'Self Care', time: '0900 - 1100'),
                      SizedBox(height: 15,),
                      ScheduleClass(colour: Colors.red, classTitle: 'Sex Education', time: '1500 - 1700'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}




class appBar_educator extends StatelessWidget {

  const appBar_educator({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper = new AuthHelper();

//fgdgd
    return FutureBuilder<String?>(
      future: authHelper.getCurrentUsername(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
        String? tutorName = snapshot.data;
        return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 180,
        backgroundColor: purple4,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: appBarLabel.copyWith(fontSize: 35),
                          ),
                          Text(
                            'Tutor $tutorName',
                            style: appBarLabel.copyWith(fontSize: 26),
                          ),
                        ],
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        color: Colors.white,
                        icon: Icon(
                          Icons.settings,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SettingPage.id);
                        },
                      ),
                    ],
                  ),
                  // Container(
                  //     child: searchBar(
                  //   width: 400,
                  //   height: 30,
                  // )),
                ],
              ),
            ),
          ],
        ),
        );
        }
        }

        return Container(); // Placeholder widget
      },
    );
  }
}
