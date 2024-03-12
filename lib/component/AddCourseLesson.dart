import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/educator_screen/add_lesson.dart';
import '../constants.dart';
import '../educator_screen/upload_course.dart';


class AddButton extends StatelessWidget {
  AddButton(
      {this.title,
      this.path,
      this.courseName,
      required this.isCourse,
      required this.isEnroll,
      this.refreshPage});

  final String? title;
  final String? path;
  String? courseName = "";
  bool isCourse;
  bool isEnroll;
  final VoidCallback? refreshPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print("Pressed Add lesson button");
        // print("At add course lesson: " + courseName!);
        print(title!);
        if (isCourse && !isEnroll) {
          // final result = await Navigator.pushNamed(
          //   context,
          //   path!,
          // );
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadCourse(),
            ),
          );
          print("back to add course lesson");
          // if (result != null) {
            print("Result is not null, trying to call callback");
            if (refreshPage != null) {
              refreshPage!();
            }
          // }
        } else {
          // final result = Navigator.pushNamed(context, path!,
          //     arguments: {"courseTitle": courseName});
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddLesson(lessonTitleS: courseName,),
            ),
          );
          print("back to add course lesson");
          // if (result != null) {
            print("Result is not null, trying to call callback");
            if (refreshPage != null) {
              refreshPage!();
            }
          // }
        }
      },
      child: Container(
          child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.add,
              size: 19,
              color: Colors.black,
            ),
            Text(
              title!,
              style:
                  appLabelTextStyle.copyWith(color: Colors.black, fontSize: 14),
            )
          ],
        ),
      )),
    );
  }
}
