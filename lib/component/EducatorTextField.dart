import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class educator_textField extends StatelessWidget {
  educator_textField({
    this.title,
    this.hintText
  });
  final String? title;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: kTextFieldLabelStyle.copyWith(fontSize: 15),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){},
            decoration: kTextFieldDecoration.copyWith(
              hintText: hintText!,
              hintStyle: TextStyle(
                fontFamily: fontFamily2,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}