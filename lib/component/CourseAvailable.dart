import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/educator_screen/add_lesson.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';

import '../constants.dart';
import '../educator_screen/upload_course.dart';
import '../helperMethods/AuthHelper.dart';
import 'AddCourseLesson.dart';

class CourseAvailable extends StatefulWidget {
  static const String id = 'course_available';

  CourseAvailable(
      {this.coursePath,
      this.imagePath,
      this.courseName,
      this.status,
      this.moreOption,
      this.refreshPage,
      this.refreshPageFromSecondWidget});

  final String? coursePath;
  final String? imagePath;
  final String? courseName;
  final String? status;
  final VoidCallback? moreOption;
  final VoidCallback? refreshPage;
  final VoidCallback? refreshPageFromSecondWidget;

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
                  CircleAvatar(
                    radius: 28,
                    child: ClipOval(
                      child: Image.network(
                        widget.imagePath!,
                        fit: BoxFit.cover,
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
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:210,
                        child: Text(
                          widget.courseName!,
                          style: appLabelTextStyle,
                          softWrap: true,
                        ),
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
          // Container(
          //   width: 25,
          //   child: IconButton(
          //     icon: Icon(Icons.more_vert_rounded),
          //     color: purple4,
          //     onPressed: () {
          //       //show pop up box here
          //
          //
          //       print('more option tapped');
          //     },
          //   ),
          // )
          Container(
            width: 25,
            child: IconButton(
              icon: Icon(Icons.more_vert_rounded),
              color: purple4,
              onPressed: () {
                // Find the RenderBox of the IconButton
                RenderBox button = context.findRenderObject() as RenderBox;

                // Get the global position of the button
                var position = button.localToGlobal(Offset.zero);

                // Calculate the offset for the PopupMenu
                double topOffset = position.dy + button.size.height;
                double leftOffset = position.dx;
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(leftOffset, topOffset, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Text('Modify'),
                      value: 'modify',
                    ),
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 'delete',
                    ),
                  ],
                ).then((value) {
                  if (value == 'modify') {
                    // Run the function for option 1
                    //open AddCourse page with isModify
                    Navigator.pushNamed(context,UploadCourse.id);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddButton(
                    //   title: 'Modify Course',
                    //   path: UploadCourse.id,
                    //   isCourse: true,
                    //   isEnroll: false,
                    //   isModify: true,
                    //   refreshPage: widget.refreshPageFromSecondWidget,
                    // )));
                  } else if (value == 'delete') {
                    // Run the function for option 2
                    DbHelper dbHelper = new DbHelper();
                    if(widget.courseName != null){
                      dbHelper.deleteCourseFromFirestore(widget.courseName!);
                      setState(() {
                        if(widget.refreshPageFromSecondWidget != null){
                          widget.refreshPageFromSecondWidget!();
                          print("refreshed page");
                        }
                      });
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
