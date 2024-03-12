import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/dashboard.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/signup_page.dart';
import '../component/UserButton.dart';
import '../component/ElevatedButton.dart';

class UserPage extends StatefulWidget {
  static const String id = 'user_page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userType=''; // Variable to store user selection
  bool isEducatorSelected = false;
  bool isUserSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'I\'m a ...',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  fontFamily: fontFamily,
                ),
              ),
            ),
            SizedBox(height: 25,),
            UserButton(
              title: 'Educator',
              imagePath: 'images/educator.png',
              onPressed: () {
                setState(() {
                  userType = 'Educator'; // Set user type to Educator
                  isEducatorSelected = true;
                  isUserSelected = false;
                });
              },
              isSelected: isEducatorSelected,
            ),
            SizedBox(height: 20,),
            UserButton(
              title: 'User',
              imagePath: 'images/user.png',
              onPressed: () {
                setState(() {
                  userType = 'User'; // Set user type to User
                  isUserSelected = true;
                  isEducatorSelected = false;
                });
              },
              isSelected: isUserSelected,
            ),
            SizedBox(height: 120,),
            elevatedButton(
              title: 'Proceed',
              color: purple1,
              fontSize: 15,
              fontColor: Colors.white,
              onPressed: () {
                if (userType == 'Educator') {
                  Navigator.pushNamed(context, LoginPage.id); // Navigate to Dashboard if user is an Educator
                } else if (userType == 'User') {
                  Navigator.pushNamed(context, LoginPage.id); // Navigate to SignUpPage if user is a User
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
