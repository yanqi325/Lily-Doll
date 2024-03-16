import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';
import '../educator_screen/student_details.dart';
import '../helperMethods/AuthHelper.dart';

class EnrolledStudentCard extends StatelessWidget {
  EnrolledStudentCard({
    this.path,
    this.imagePath,
    this.studentName,
    this.moreOption,
    required this.studentDetailsNewWidget,
    required this.courseTitle,
    required this.refreshPage
  });

  final String? path;
  final String? imagePath;
  final String? studentName;
  final String? courseTitle;
  final VoidCallback? moreOption;
  StudentDetails studentDetailsNewWidget;
  final VoidCallback? refreshPage;

AuthHelper authHelper = new AuthHelper();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              // Navigator.pushNamed(context, path!);
              String? userId = await authHelper.getCurrentUserId();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => studentDetailsNewWidget),
                // MaterialPageRoute(builder: (context) => StudentDetails(courseTitle:"Boxing",userName: "Jingen",)),
              );
              //fdsfd
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28, // Adjust the radius according to your needs
                    backgroundImage: AssetImage(
                      imagePath!,
                    ), // retrieve from firebase?
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          studentName!,
                          style: appLabelTextStyle,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),

                ],
              ),

            ),
          ),
          Container(
            width: 25,
            child: IconButton(
              icon: Icon(Icons.more_vert_rounded),
              color: purple4,
              onPressed: () {
                print('more option tapped');
                moreOption;
                showPopupMenu(context);
              },
            ),
          ),
        ],
      ),
    );
  }
  void showPopupMenu(BuildContext context) {

    GlobalKey _popupKey = GlobalKey();

    // Find the RenderBox of the IconButton
    RenderBox button = context.findRenderObject() as RenderBox;

    // Get the global position of the button
    var position = button.localToGlobal(Offset.zero);

    // Calculate the offset for the PopupMenu
    double topOffset = position.dy + button.size.height;
    double leftOffset = position.dx;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(leftOffset, topOffset, 20, 0),
      items: [
        PopupMenuItem(
          child: Text('Delete'),
          value: 'delete',
          onTap: () async {
//delete code here
          DbHelper dbHelper = new DbHelper();
          String userId = await dbHelper
              .getUsernamesFromUsersExtended(
              studentName!);
          String? educatorId = await authHelper
              .getCurrentUserId();
          dbHelper.deleteUserFromEnrolledCourses(studentName!, courseTitle!);
          dbHelper.deleteUserFromEnrolledUsers(educatorId!, courseTitle!, userId);
          refreshPage!();
          },
        ),
      ],
    );
  }

}






