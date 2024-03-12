import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'ToggleButton.dart';

class ToggleButtonCard extends StatelessWidget {
  ToggleButtonCard({this.label, this.onChange});
  final String? label;
  Function? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Container(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$label',
                  style: appBarLabel.copyWith(color: Colors.black,fontSize: 18),
                ),
                ToggleButton(isSwitched: false,onChanged: (){onChange;},),
              ],
            ),
          
          ),
        ),
      ),
    );
  }
}

