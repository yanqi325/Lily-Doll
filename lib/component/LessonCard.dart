import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';
import 'ElevatedButton.dart';

class LessonCard extends StatelessWidget {
  LessonCard({
    this.onPressedContinue,
    this.onPressedRestart,
    required this.lessonTitle,
    required this.lessonNo,
    required this.lessonProgress,
    required this.minutesLeft
  });

  final VoidCallback? onPressedContinue;
  final VoidCallback? onPressedRestart;
  String lessonNo="";
  String lessonTitle="";
  //0-100%
  int lessonProgress=0;
  int minutesLeft = 0;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4BAA3),
                      borderRadius:
                          BorderRadius.circular(6.0), // Set the desired radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Lesson ${lessonNo}',
                          style:
                              appLabelTextStyle.copyWith(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                    child: Image.asset(
                  'images/lesson_pic.png',
                  scale: 2.5,
                )),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            lessonTitle,
                            style: appLabelTextStyle.copyWith(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 8.0,
                          percent: 0.7,
                          backgroundColor: Colors.cyan[50],
                          progressColor: Colors.cyan,
                          barRadius: Radius.circular(12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${lessonProgress}%",
                              style: appLabelTextStyle.copyWith(
                                  color: Colors.black, fontSize: 12),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            Text(
                              '${minutesLeft}m left',
                              style: appLabelTextStyle.copyWith(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            elevatedButton(
                              title: 'Continue',
                              fontSize: 13,
                              fontColor: Colors.black,
                              width: 110,
                              height: 40,
                              radius: 8,
                              elevation: 2,
                              color: Color(0xFFEFD2C5),
                              onPressed: onPressedContinue,
                            ),
                            elevatedButton(
                              title: 'Restart',
                              fontSize: 13,
                              fontColor: Colors.black,
                              width: 110,
                              height: 40,
                              radius: 8,
                              elevation: 2,
                              color: Color(0xFFABDBD1),
                              onPressed: onPressedRestart,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
