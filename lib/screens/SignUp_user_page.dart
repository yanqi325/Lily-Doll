import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/dashboard.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/signup_page.dart';
import '../component/UserButton.dart';
import '../component/ElevatedButton.dart';

class SignUpUserPage extends StatefulWidget {
  static const String id = 'SignUp_user_page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<SignUpUserPage> {
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
                'Sign Up as A ...',
                style: TextStyle(
                  fontSize: 35,
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
                Navigator.pushNamed(context, SignUpPage.id,arguments: {
                  "userType" : userType
                } );
              },
            ),
          ],
        ),
      ),
    );
  }
}
