import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

//NOTE: WILL OVERFLOW IF PERCENTAGE IS 100%
class TouchesPart extends StatelessWidget {
  TouchesPart({
    this.label,
    this.color,
    this.percentage
  });

  final String? label;
  final Color? color;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$label',
            style: appLabelTextStyle.copyWith(color: purple4, fontSize: 14),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: LinearPercentIndicator(
            lineHeight: 8.0,
            percent: percentage ?? 0.0,
            backgroundColor: color?.withOpacity(0.2),
            progressColor: color,
            barRadius: Radius.circular(12),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            (percentage! * 100).toInt().toString() + "%",
            style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 12),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
