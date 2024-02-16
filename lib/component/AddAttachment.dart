import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddAttachment extends StatelessWidget {
  AddAttachment({
    this.title,
    this.onPressed
  });
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90,30),
          primary: purple4, // Set the background color of the button
          onPrimary: Colors.white, // Set the text color
          padding: EdgeInsets.only(left: 5), // Set padding for the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Set the border radius
          ),
        ),
        child: Container(
          width: 100,
          height: 20,
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 5,),
              Text(title!)
            ],
          ),
        )
    );
  }
}
