import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class TouchesPart extends StatelessWidget {
  TouchesPart({
    this.label,
    this.color,
  });

  final String? label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$label',
            style: appLabelTextStyle.copyWith(color: purple4),
          ),
        ),
        LinearPercentIndicator(
          width: 180.0, // Adjust width based on your design
          lineHeight: 8.0,
          percent: 0.7,
          backgroundColor: color?.withOpacity(0.2),
          progressColor: color,
          barRadius: Radius.circular(12),
        ),
        Text('63%', style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 12)),
      ],
    );
  }
}
