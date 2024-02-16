
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAddButton extends StatelessWidget {
  UploadAddButton({
    this.title,
    this.onPressed
  });
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(90,25),
          primary: Colors.black, // Set the border color
          side: BorderSide(color: Colors.grey), // Set the border color
          padding: EdgeInsets.symmetric(horizontal: 13), // Set padding for the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Set the border radius
          ),
        ),
        child: Text(title!),
      ),
    );
  }
}