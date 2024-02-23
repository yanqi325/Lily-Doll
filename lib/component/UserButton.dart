import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';

class UserButton extends StatefulWidget {
  UserButton({
     this.title,
     this.imagePath,
     this.onPressed,
     this.isSelected,
     this.updateSelected,
  });

  final String? title;
  final String? imagePath;
  final VoidCallback? onPressed;
  final bool? isSelected;
  final Function(bool)? updateSelected;

  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        widget.onPressed!();
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        minimumSize: Size(240.0, 60.0),
        backgroundColor: widget.isSelected! ? Colors.white70 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      icon: ImageIcon(
        AssetImage(widget.imagePath!),
        color: Colors.black,
        size: 30,
      ),
      label: Text(
        widget.title!,
        style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

