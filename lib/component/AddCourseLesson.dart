import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../educator_screen/upload_course.dart';

class AddButton extends StatelessWidget {
  AddButton({
    this.title,
    this.path,
    this.courseName,
    required this.isCourse
  });
  final String? title;
  final String? path;
  String? courseName="";
  bool isCourse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print("At add course lesson: " + courseName!);
        print(title!);
        if (isCourse){
          Navigator.pushNamed(context, path!, );

        }else{
          Navigator.pushNamed(context, path!, arguments: {
            "courseTitle" : courseName
          } );

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
                  style: appLabelTextStyle.copyWith(
                      color: Colors.black, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
