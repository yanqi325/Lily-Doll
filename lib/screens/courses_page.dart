import 'package:flutter/material.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/NavigationBar.dart';
import '../helperMethods/DbHelper.dart';

class CoursesPage extends StatefulWidget {
  static const String id = 'courses_page';

  @override
  _CoursesPageScreenState createState() => _CoursesPageScreenState();
}

class _CoursesPageScreenState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = new DbHelper();

    //hard coded values: do not touch
    Widget course1 = CourseDescription(
      courseTitle: "Sex Education",
      numOfStudents: 190,
      descText:
          "This is a course where students will learn about their rights of their body",
      imagePath: 'images/sex_education.png',
      altText: "You are not enrolled in this course!",
      isEnrolled: false,
      isEducatorMode: false,
    );

    Widget course2 = CourseDescription(
      courseTitle: "Daily Life",
      numOfStudents: 3,
      descText:
          "This is a course where students will learn about the ins and outs of life",
      imagePath: 'images/daily_life.png',
      altText: "You are not enrolled in this course!",
      isEnrolled: false,
      isEducatorMode: false,

    );

    Widget course3 = CourseDescription(
      courseTitle: "Shapes",
      numOfStudents: 65,
      descText:
          "This is a course where students will learn about the different types of shapes",
      imagePath: 'images/shape.png',
      altText: "You are not enrolled in this course!",
      isEnrolled: false,
      isEducatorMode: false,

    );
    //dynamically add courses
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(initialIndex: 0),
      body: FutureBuilder(
          future: dbHelper.getEnrolledCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              print(snapshot.data!.length);
              return Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Users.username,
                            style: appLabelTextStyle.copyWith(fontSize: 28),
                          ),
                          Text(
                            'Welcome to our courses',
                            style: appLabelTextStyle.copyWith(color: purple6),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: purple4,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 120,
                            width: 400,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Users.level,
                                        style: appLabelTextStyle.copyWith(
                                            color: Colors.white, fontSize: 28),
                                      ),
                                      Text(
                                        'course',
                                        style: appLabelTextStyle.copyWith(
                                            color: purple6),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                iconButton(
                                  label: 'Sex Education',
                                  //extract from Courses class?
                                  image: 'images/sex_education.png',
                                  //extract from Courses class?
                                  route: course1,
                                ), //add route
                                SizedBox(
                                  width: 20,
                                ),
                                iconButton(
                                  label: 'Daily Life',
                                  image: 'images/daily_life.png',
                                  route: course2,
                                ),
                                //add route
                                SizedBox(
                                  width: 20,
                                ),
                                iconButton(
                                  label: 'Shape',
                                  image: 'images/shape.png',
                                  route: course3,
                                ), //add route
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Learn at Your Own Pace',
                            style: appLabelTextStyle.copyWith(fontSize: 22),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          //Generate user courses based on firebase
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      CoursesCard(
                                        courseTitle:
                                            snapshot.data![index].courseTitle,
                                        thumbnailUrl:
                                            snapshot.data![index].thumbnailUrl,
                                        courseDescWidget: CourseDescription(
                                          courseTitle:
                                              snapshot.data![index].courseTitle,
                                          numOfStudents: 190,
                                          descText:
                                              snapshot.data![index].courseDesc,
                                          imagePath: snapshot
                                              .data![index].thumbnailUrl,
                                          altText: "",
                                          isEnrolled: true,
                                          isEducatorMode: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: -35,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Image.asset('images/teacher.png'),
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
