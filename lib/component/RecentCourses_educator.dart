import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'IconButton.dart';

class RecentCourses_educator extends StatelessWidget {
  RecentCourses_educator({
    this.iconImage,
    this.courseTitle,
    this.coursePath,
    this.managePath,
    required this.courseDescWidget
  });
  String? iconImage;
  String? courseTitle;
  String? coursePath;
  String? managePath;
  final Widget courseDescWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('Course tapped');
        //Navigator.pushNamed(context, coursePath!);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        width: 250, // Adjust the width as needed
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: iconButton(
                  label: '',
                  image: iconImage,

                  //extract from Courses class?
                ),
              ), //
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseTitle!,
                    style: appLabelTextStyle.copyWith(fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle tap action here
                      print("Manage tapped!");
                      // Navigator.pushNamed(context, managePath!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => courseDescWidget),
                      );
                    },
                    child: Text(
                      'Manage',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}