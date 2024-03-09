import 'package:flutter/material.dart';
import '../constants.dart';

class iconButton extends StatelessWidget {
  final String? label; //link to Courses class label?
  final Widget? route;
  final String? image; //link to Courses class image?

  iconButton({this.label, this.route, this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, route!);
          if(route != null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route!),
            );
          }
        },
        splashColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(
                image!,
              ), // Replace with your image asset path
            ),
            Text(
              '$label',
              style: appLabelTextStyle.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
