import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class CourseProgressionCard extends StatelessWidget {
  CourseProgressionCard({
    this.courseName,
    this.coursePercent,

  });
  final String? courseName;
  final double? coursePercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(courseName!, style: appLabelTextStyle.copyWith(color: Colors.black),),
            SizedBox(height: 15,),
            LinearPercentIndicator(
              width: 305.0,
              lineHeight: 8.0,
              percent: coursePercent!,
              backgroundColor: purple5,
              progressColor: purple7,
              barRadius: Radius.circular(12),
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('${(coursePercent! * 100).toStringAsFixed(0)}%', style: appLabelTextStyle.copyWith(fontSize: 12, color: Colors.grey)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
