import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Cardboard extends StatelessWidget {
  Cardboard({this.label, this.labelContent, this.onPressed, this.icon});
  String? label;
  String? labelContent;
  Function? onPressed;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(13),
      ),
      height: 57,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                icon,
                color: purple4,
                size: 20,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$label',
                    style: appBarLabel.copyWith(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '$labelContent',
                    style: appBarLabel.copyWith(fontSize: 9, color: Colors.grey),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                print('Edit pressed');
                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Edit',
                  style: signUpButtonTextStyle.copyWith(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
