import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';

class UserButton extends StatelessWidget {
  const UserButton({this.title, this.imagePath, this.onPressed});

  final String? title;
  final String? imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        minimumSize: Size(240.0, 60.0),
        backgroundColor: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      icon: ImageIcon(
        AssetImage(imagePath!),
        color: Colors.black,
        size: 30,
      ),
      label: Text(
        title!,
        style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}