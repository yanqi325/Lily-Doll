import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';

class CourseAvailable extends StatefulWidget {
  static const String id = 'course_available';
  CourseAvailable({
    this.coursePath,
    this.imagePath,
    this.courseName,
    this.status,
    this.moreOption,
  });
  final String? coursePath;
  final String? imagePath;
  final String? courseName;
  final String? status;
  final VoidCallback? moreOption;

  @override
  _CourseAvailable createState() => _CourseAvailable();
}

class _CourseAvailable extends State<CourseAvailable> {
  TextEditingController searchController = TextEditingController(); // Added controller


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, widget.coursePath!);
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 56,
                    height: 56,
                    image: AssetImage(
                      widget.imagePath!,
                    ),
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
