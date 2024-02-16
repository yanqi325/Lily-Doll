import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/forgot_password.dart';
import 'package:project_lily/screens/home_page.dart';
import 'package:project_lily/screens/user_page.dart';
import '../component/TextField.dart';
import '../component/ElevatedButton.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  String? email;
  String? password;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children:[
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              SizedBox(height: 90,),
              Text('Log In',
                style: pageTitleTextStyle,
              ),
              SizedBox(height: 30,),
              LabeledTextField(
                label: 'Email',
                value: email,
                onChanged: (value) {
                    email = value;
                },
                keyboardType: TextInputType.emailAddress,
                hintText: 'example@gmail.com',
              ),
              SizedBox(height: 50,),
              LabeledTextField(
                label: 'Password',
                value: password,
                onChanged: (value) {
                  password = value;
                },
                hintText: 'Enter your password here',
                obscure: obscure,
                icon: Icons.remove_red_eye,
                onIconPressed: (){
                  setState(() {
                    obscure= !obscure;
                  });
                },
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  //print('forgot password');
                  Navigator.pushNamed(context, ForgotPassword.id);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text('Forgot uour password?',
                      style: signUpButtonTextStyle.copyWith(color: purple3, fontSize:12,fontWeight: FontWeight.bold, fontFamily: fontFamily2 ),
                    ),
                  ),
                ),
              ],
              ),
              SizedBox(height: 100,),
              Center(
                  child: elevatedButton(
                    title: 'Log In',
                    color:purple1,
                    fontSize: 15,
                    fontColor: Colors.white,
                    onPressed: (){
                      Navigator.pushNamed(context, HomePage.id);
                    },
                  ),
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
          ),
        ),
            ),
    );
  }
}
