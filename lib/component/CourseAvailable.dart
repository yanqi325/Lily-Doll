import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helperMethods/AuthHelper.dart';

class CourseAvailable extends StatefulWidget {
  static const String id = 'course_available';

  CourseAvailable(
      {this.coursePath,
      this.imagePath,
      this.courseName,
      this.status,
      this.moreOption,
      this.refreshPage});

  final String? coursePath;
  final String? imagePath;
  final String? courseName;
  final String? status;
  final VoidCallback? moreOption;
  final VoidCallback? refreshPage;

  @override
  _CourseAvailable createState() => _CourseAvailable();
}

class _CourseAvailable extends State<CourseAvailable> {
  TextEditingController searchController =
      TextEditingController(); // Added controller
  AuthHelper authHelper = new AuthHelper();

  //hard coded url for basic 3 courses, sex ed, shapes, daily life

  @override
  Widget build(BuildContext context) {
    String backupUrl = "";
    if (widget.courseName == "Sex Education") {
      backupUrl = "images/sex_education.png";
    } else if (widget.courseName == "Shapes") {
      backupUrl = "images/shape.png";
    } else if (widget.courseName == "Daily Life") {
      backupUrl = "images/daily_life.png";
    } else {
      backupUrl = "images/puzzle.png";
    }
    // print("At course available course title: " + widget.courseName!);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              final result = await Navigator.pushNamed(
                  context, widget.coursePath!,
                  arguments: {
                    "courseTitle": widget.courseName,
                    "educatorId": await authHelper.getCurrentUserId()
                  });
              //wait for add action to finish, then refresh page
              if (result != null) {
                print("Result is not null, trying to call callback");
                setState(() {
                  if(widget.refreshPage != null){
                    widget.refreshPage!();
                  }
                });
              }
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image(
                  //   width: 56,
                  //   height: 56,
                  //   image:
                  // AssetImage(
                  //   widget.imagePath!,
                  //   // ),
                  // ),
                  Image.network(
                    widget.imagePath!,
                    width: 56,
                    height: 56,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // Error occurred while loading the image, display default image instead
                      return Image.asset(
                        backupUrl,
                        width: 56,
                        height: 56,
                      );
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.courseName!,
                        style: appLabelTextStyle,
                      ),
                      if (widget.status != null) ...[
                        Text(
                          widget.status!,
                          style: appLabelTextStyle.copyWith(
                            fontSize: 10,
                            fontFamily: fontFamily,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded),
            color: purple4,
            onPressed: () {
              print('more option tapped');
            },
          )
        ],
      ),
    );
  }
}
