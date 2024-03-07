import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/user_page.dart';
import '../component/TextField.dart';
import '../component/ElevatedButton.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'signup_page';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? username;
  String? email;
  String? password;
  bool obscure = true;

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: pageTitleTextStyle,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledTextField(
                    label: 'Username',
                    value: username,
                    onChanged: (value) {
                      username = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'example123',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LabeledTextField(
                    label: 'Email',
                    value: email,
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'example@gmail.com',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LabeledTextField(
                    label: 'Password',
                    value: password,
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: 'Enter your password here',
                    obscure: obscure,
                    icon: Icons.remove_red_eye,
                    onIconPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Column(
                children: [
                  Text(
                    'Or Sign Up with',
                    style: signUpTextStyle.copyWith(
                        color: purple3, fontSize: 11, fontFamily: fontFamily),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle the onPressed event for the first IconButton
                        },
                        icon: CircleAvatar(
                          radius: 30,
                          child: Image.asset(
                              'images/google.png'), // Replace with your image path
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle the onPressed event for the first IconButton
                        },
                        icon: CircleAvatar(
                          radius: 30,
                          child: Image.asset(
                              'images/facebook.png'), // Replace with your image path
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: elevatedButton(
                  title: 'Sign Up',
                  color: purple1,
                  fontSize: 15,
                  fontColor: Colors.white,
                  onPressed: () {
                    if (username == null || email == null || password == null) {
                      showError('Please fill in all the fields.');
                    } else {
                      //check authentication here., correct then go to home page
                      //go to login page

                    }
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ', style: signUpTextStyle),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Text(
                      'Sign In',
                      style: signUpButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
