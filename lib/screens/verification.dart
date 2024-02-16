import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/login_page.dart';
import '../component/TextField.dart';
import '../component/ElevatedButton.dart';

class Verification extends StatefulWidget {
  static const String id = 'verification';
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<Verification> {
  String? phoneNum;
  String? verification_code;


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
                        children: [
                          Text('Forgot Password',
                            style: pageTitleTextStyle.copyWith(color: Colors.black),
                          ),
                          SizedBox(height: 25,),
                          Text(
                              'Plese enter the 4-digit PIN sent to your phone.',
                              textAlign: TextAlign.center,
                              style: kTextFieldLabelStyle,
                            ),
                          SizedBox(height: 25,),
                          Container(
                            width: 200,
                            child: PinCodeFields(
                              length: 4,
                              borderColor: purple3,
                              textStyle: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 18,
                              ),
                              onComplete: (output) {
                                verification_code = output;
                                print(verification_code);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              print('Resend PIN');
                            },
                            child: Text('Re-send PIN',
                              style: signUpButtonTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: purple3,
                              ),
                            ),
                          ),
                          SizedBox(height: 80,),
                          elevatedButton(
                            title: 'Submit',
                            color:purple1,
                            fontSize: 15,
                            fontColor: Colors.white,
                            onPressed: (){},
                          ),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: (){
                              //print('Sign up pressed');
                              Navigator.popUntil(context, ModalRoute.withName(LoginPage.id));

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
