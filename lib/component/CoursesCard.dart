import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/Courses.dart';
import '../constants.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({this.onPressed});
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 18,),
          Image.asset(
            "Image url here",
            scale: 2.5,
          ),
          SizedBox(width: 30,),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Random text here",
              style: appLabelTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 43.0),
            child: IconButton(
              icon: Icon(
                Icons.play_circle_rounded,
                size: 36.0,
                color: purple4,
              ),
              onPressed: (){
                  onPressed;
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
