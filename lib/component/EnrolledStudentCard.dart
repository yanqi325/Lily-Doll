import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';

class EnrolledStudentCard extends StatelessWidget {
  EnrolledStudentCard({
    this.path,
    this.imagePath,
    this.studentName,
    this.moreOption
  });
  final String? path;
  final String? imagePath;
  final String? studentName;
  final VoidCallback? moreOption;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, path!);
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
                      Text(
                        studentName!,
                        style: appLabelTextStyle,
                      ),
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
              moreOption;
            },
          ),
        ],
      ),
    );
  }
}




