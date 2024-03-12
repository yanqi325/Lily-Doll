import 'package:flutter/material.dart';
import 'package:project_lily/Data/Lessons.dart';
import 'package:project_lily/component/AppBar.dart';
import 'package:project_lily/component/LessonCard.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/screens/lessonVideoYT.dart';

class CoursesChapter extends StatefulWidget {
  static const String id = 'courses_chapter';

  @override
  _CoursesChapterScreenState createState() => _CoursesChapterScreenState();
}

class _CoursesChapterScreenState extends State<CoursesChapter> {
  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: args["courseTitle"]), //Courses.label
      ),
      body: Container(
        color: backgroundColor2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TODO: DYNAMICALLY GENERATE THIS BASED ON FIREBASE
              FutureBuilder<List<Lessons>>(
                future: dbHelper.getLessonsFromCourseUser(args["courseTitle"]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text('No lessons found.'));
                  } else {
                    // Build LessonCard widgets using fetched data
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Lessons lesson = snapshot.data![index];
                        return LessonCard(
                          lessonTitle: lesson.lessonTitle,
                          lessonNo: index.toString(),
                          lessonProgress: 54,
                          minutesLeft: 34,
                          isLocked: lesson.isLocked,
                          onPressedContinue: ()=> {

                            //create and navigate to video page
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LessonVideoYT(lessonNo: index.toString(),lessonTitle: lesson.lessonTitle ,isUser: true, courseTitle: args["courseTitle"],)),
                          )

                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}