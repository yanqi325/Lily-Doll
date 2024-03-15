import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import '../component/AppBar.dart';


class AboutUs extends StatefulWidget {
  static const String id = 'about_us';
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUs> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'About Us',
        icon: null,),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('images/logo.png',scale: 1.3,),
                  ),
                  Text('with AIDA',
                    style: TextStyle(
                      fontFamily: 'AoboshiOne',
                      color: purple4,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 200,
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text('Lily Doll is a valuable educational tool for autistic children, providing a sense of comfort and security. '
                            '\n \n Lily Doll also helps children promoting social and emotional development, facilitating imaginative play.',
                          textAlign: TextAlign.center,
                          style: appBarLabel.copyWith(color: purple4, fontSize: 14),
                        ),
                      ),
                    ),
                  )

                ],
              ),

            ],
          ),
        ),
      ),


    );
  }

}

