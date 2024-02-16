import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/educator_screen/dashboard.dart';
import 'package:project_lily/screens/signup_page.dart';
import '../component/UserButton.dart';
import '../component/ElevatedButton.dart';

class UserPage extends StatelessWidget {
  static const String id = 'user_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('I\'m a ...',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamily,
              ),
              ),
            ),
            SizedBox(height: 25,),
            UserButton(title: 'Educator', imagePath: 'images/educator.png', onPressed: (){Navigator.pushNamed(context, Dashboard.id);}),
            SizedBox(height: 20,),
            UserButton(title: 'User', imagePath: 'images/user.png'),
            SizedBox(height: 120,),
            elevatedButton(
                title: 'Proceed',
                color:purple1,
                fontSize: 15,
                fontColor: Colors.white,
                onPressed:(){
                  Navigator.pushNamed(context, SignUpPage.id);
                }
            ),

          ],
        ),
    ),
    );
  }
}


