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
        courseTitle: "Maths",
        numOfStudents: 190,
        descText:
            "A math course tailored for autistic children utilizes visual aids and structured, repetitive exercises to facilitate understanding and engagement. Through personalized support and a sensory-friendly environment, it aims to foster confidence and success in mathematical concepts.",
        imagePath: 'images/maths.png',
        altText: "You are not enrolled in this course!",
        isEnrolled: false,
        isEducatorMode: false,
        isOnlineAsset: false);

    Widget course2 = CourseDescription(
        courseTitle: "Reading",
        numOfStudents: 3,
        descText:
            "Tailored to the unique needs of autistic children, our reading course offers a supportive environment where every child can thrive. With specialized techniques and personalized attention, we foster a love for reading while nurturing individual strengths.",
        imagePath: 'images/reading.png',
        altText: "You are not enrolled in this course!",
        isEnrolled: false,
        isEducatorMode: false,
        isOnlineAsset: false);

    Widget course3 = CourseDescription(
        courseTitle: "Speaking",
        numOfStudents: 65,
        descText:
            "A specialized speaking course tailored for autistic children provides structured and supportive communication environments, fostering their confidence and language skills. Through personalized approaches and understanding of their unique needs, these courses aim to empower autistic children to express themselves more effectively.",
        imagePath: 'images/speaking.png',
        altText: "You are not enrolled in this course!",
        isEnrolled: false,
        isEducatorMode: false,
        isOnlineAsset: false);
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
                                  label: 'Maths',
                                  //extract from Courses class?
                                  image: 'images/maths.png',
                                  //extract from Courses class?
                                  route: course1,
                                ), //add route
                                SizedBox(
                                  width: 20,
                                ),
                                iconButton(
                                  label: 'Reading',
                                  image: 'images/reading.png',
                                  route: course2,
                                ),
                                //add route
                                SizedBox(
                                  width: 20,
                                ),
                                iconButton(
                                  label: 'Speaking',
                                  image: 'images/speaking.png',
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
                                            courseTitle: snapshot
                                                .data![index].courseTitle,
                                            numOfStudents: 190,
                                            descText: snapshot
                                                .data![index].courseDesc,
                                            imagePath: snapshot
                                                .data![index].thumbnailUrl,
                                            altText: "",
                                            isEnrolled: true,
                                            isEducatorMode: false,
                                            isOnlineAsset: true),
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
