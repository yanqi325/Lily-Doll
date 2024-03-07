import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/setting_page.dart';

import '../constants.dart';
import '../screens/profile_page.dart';

class appBar extends StatelessWidget {
  appBar({this.title, this.icon = Icons.settings, this.route = SettingPage.id, this.colors = purple4});
  String? title;
  IconData? icon = Icons.menu;
  String? route = SettingPage.id;
  Color colors = purple4;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      backgroundColor: colors,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Text('$title',
                textAlign: TextAlign.center,
                style: appBarLabel.copyWith(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          alignment: Alignment.topRight,
          color: Colors.white,
          icon: Icon(icon, size: 40,),
          onPressed: () {
            Navigator.pushNamed(context, route! );
          },
        ),
      ], // Set the title
    );
  }
}

