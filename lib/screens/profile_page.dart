import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_lily/screens/welcome_screen.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../component/Cardboard.dart';
import '../component/NavigationBar.dart';
import '../helperMethods/AuthHelper.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper = new AuthHelper();


    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(85), // Set the preferred height
          child: appBar(title: 'Profile',
          icon: null,),
        ),
        body: FutureBuilder<String?>(
        future: authHelper.getCurrentUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              String? userName = snapshot.data;
              return Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Avatar(radius: 36, align: Alignment.center,),
                      Text(userName!,
                        textAlign: TextAlign.center,
                        style: appBarLabel.copyWith(
                            fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 12,),
                      Cardboard(label: 'Name',
                        labelContent: userName,
                        icon: Icons.people_alt,),
                      SizedBox(height: 8,),
                      Cardboard(label: 'Email',
                        labelContent: Users.email,
                        icon: Icons.email,),
                      SizedBox(height: 8,),
                      Cardboard(label: 'Password',
                        labelContent: 'Tap to Change Password',
                        icon: Icons.lock,),
                      SizedBox(height: 8,),
                      Cardboard(label: 'Phone Number',
                        labelContent: Users.phoneNum,
                        icon: Icons.phone_android,),
                      SizedBox(height: 8,),
                      Cardboard(label: 'Payment',
                        labelContent: 'Tap to Change Payment',
                        icon: Icons.credit_card,),
                      SizedBox(height: 8,),
                      Cardboard(label: 'Privacy Policy',
                        labelContent: 'Tap to See Privacy Policy',
                        icon: Icons.privacy_tip,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            onTap: () {
                              print('Log out');
                              AuthHelper authHelper = new AuthHelper();
                              authHelper.signOutUser();
                              Navigator.pushNamed(context, WelcomeScreen.id);
                            },
                            child: Text('LOG OUT',
                              style: signUpButtonTextStyle.copyWith(
                                  color: purple4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
          }
          return Container();
        },
        )


    );
  }
}



