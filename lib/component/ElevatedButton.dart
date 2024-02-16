import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class elevatedButton extends StatelessWidget {
  elevatedButton({
    this.title,
    this.color,
    this.onPressed,
    this.fontSize,
    this.fontColor,
    this.elevation = 5,
    this.icon,
    this.width =210,
    this.height = 50,
    this.align = MainAxisAlignment.center,
    this.radius =20,
  });

  final Color? color;
  final String? title;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? fontColor;
  final double? elevation;
  final IconData? icon;
  double? width;
  double? height;
  MainAxisAlignment align;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        child: Row(
          mainAxisAlignment: align,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: purple4,
              ),
              SizedBox(width: 10),
            ],
            Text(
              title!,
              style: TextStyle(
                fontSize: fontSize,
                color: fontColor,
                fontFamily: 'AoboshiOne',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
