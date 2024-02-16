import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/profile_page.dart';

class Avatar extends StatelessWidget {
  Avatar({this.radius, this.align});
  double? radius;
  Alignment? align;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: align,
      icon: CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(
            'images/profile.png'), //retrieve from firebase?
      ),
      onPressed: () {
        Navigator.pushNamed(context, ProfilePage.id);
      },
    );
  }
}