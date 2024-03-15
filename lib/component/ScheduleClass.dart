import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ScheduleClass extends StatelessWidget {
  const ScheduleClass({
    this.colour,
    this.classTitle,
    this.time,
    this.coursePath,
  });
  final Color? colour;
  final String? classTitle;
  final String? time;
  final String? coursePath;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(right: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    color: colour,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(classTitle!, style: appLabelTextStyle.copyWith(color: Colors.black),),
                      Text(time!, style: appLabelTextStyle.copyWith(color: Colors.grey, fontSize: 10),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
