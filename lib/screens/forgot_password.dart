import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/verification.dart';
import '../component/TextField.dart';
import '../component/ElevatedButton.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  String? phoneNum;

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
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [
                  Text('Oh no!',
                    style: pageTitleTextStyle.copyWith(color: purple3),
                  ),
                  Image(
                      image: AssetImage('images/puzzle.png'),
                      width: 100,
                      height: 100,),
                  SizedBox(height: 30,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38.withOpacity(0.77),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Color of the shadow
                          spreadRadius: 3, // Spread radius
                          blurRadius: 3, // Blur radius
                          offset: Offset(0,3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Forgot Password',
                            style: pageTitleTextStyle.copyWith(color: Colors.black),
                          ),
                          SizedBox(height: 25,),
                          LabeledTextField(
                            label: 'Phone number',
                            value: phoneNum,
                            onChanged: (value) {
                              phoneNum = value;
                            },
                            keyboardType: TextInputType.phone,
                            hintText: '+60-000-000-000',
                          ),
                          SizedBox(height: 120,),
                          elevatedButton(
                            title: 'Next',
                            color:purple1,
                            fontSize: 15,
                            fontColor: Colors.white,
                            onPressed: (){
                              Navigator.pushNamed(context, Verification.id);
                            },
                          ),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: (){
                              //print('Sign up pressed');
                              Navigator.pop(context);
                            },
                            child: Text('Back to login',
                              style: signUpButtonTextStyle.copyWith(
                                  fontFamily: fontFamily2,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: purple2,
                                  decorationThickness: 2.0,
                            ),
                           ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
