import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/user_page.dart';
import '../component/ElevatedButton.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('images/wallpaper.png'),
          fit: BoxFit.cover,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              alignment: Alignment.center,
              child: Image.asset('images/logo.png'),
              ),
               Text('with AIDA',
                 style: TextStyle(
                   fontFamily: 'AoboshiOne',
                   color: Colors.deepPurple,
                   fontSize: 15,
                   fontWeight: FontWeight.bold,
                 ),
               ),
              SizedBox(height: 25,),
              elevatedButton(
                  title: 'Get Started',
                  color:purple1,
                  fontSize: 15,
                  fontColor: Colors.white,
                  onPressed:(){
                    Navigator.pushNamed(context, LoginPage.id);
                  }
                  ), //add onPress
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account? ',
                    style: signUpTextStyle
                  ),
                  InkWell(
                    onTap: (){
                      //print('Sign up pressed');
                      Navigator.pushNamed(context, UserPage.id);
                    },
                    child: Text('Sign Up',
                      style: signUpButtonTextStyle,
                    ),
                  ),

                ],
              ),
              ],

          )
        ),
    );
  }
}

