import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class educator_textField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final void Function(String)? onChanged;

  educator_textField ({
    this.title,
    this.hintText,
    this.onChanged,
  });

  @override
  _EducatorTextFieldState createState() => _EducatorTextFieldState();
}

class _EducatorTextFieldState extends State<educator_textField > {
  String userEnteredValue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: kTextFieldLabelStyle.copyWith(fontSize: 15),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                userEnteredValue = value;
              });
              // Call the callback function
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: widget.hintText!,
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