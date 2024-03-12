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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 18),
                child: CircleAvatar(
                  radius: 28, // Adjust the radius as needed
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      thumbnailUrl,
                      // scale: 2.5,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // Error occurred while loading the image, display default image instead
                        return Image.asset(
                          'images/sex_education.png',
                          width: 56,
                          height: 56,
                        );
                      },
                    ),
                    ),
                  ),
              ),
              // Image.asset(
              //   thumbnailUrl,
              //   scale: 2.5,
              // ),
              SizedBox(
                width: 30,
              ),
              Text(
                courseTitle,
                style: appLabelTextStyle,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 35.0),
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
