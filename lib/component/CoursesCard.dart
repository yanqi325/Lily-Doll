import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/Courses.dart';
import '../constants.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard(
      {this.onPressed, required this.courseTitle, required this.thumbnailUrl, required this.courseDescWidget});

  final Function? onPressed;
  final String courseTitle;
  final String thumbnailUrl;
  final Widget courseDescWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
          ),
          Image.network(
            thumbnailUrl,
            // scale: 2.5,
            width: 56,
            height: 56,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              // Error occurred while loading the image, display default image instead
              return Image.asset(
                'images/puzzle.png',
                width: 56,
                height: 56,
              );
            },
          ),
          // Image.asset(
          //   thumbnailUrl,
          //   scale: 2.5,
          // ),
          SizedBox(
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              courseTitle,
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => courseDescWidget),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
