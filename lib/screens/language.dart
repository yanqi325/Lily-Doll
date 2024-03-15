import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../component/Cardboard.dart';
import '../component/NavigationBar.dart';
import '../component/ToggleButton.dart';
import '../component/ToggleButtonCard.dart';

class LanguagePage extends StatefulWidget {
  static const String id = 'language_page';
  @override
  _LanguagePageScreenState createState() => _LanguagePageScreenState();
}



class _LanguagePageScreenState extends State<LanguagePage> {
  bool isPressed = false;
  String? defaultLanguage;
  List<String> languages = [
    'English-EN',
    'English-ES',
    'Bahasa Melayu-BM',
    '简体中文-ZH',
    '繁体中文-ZH',
  ];
  int? _selectedLanguage;

  void initState() {
    super.initState();

    // Set default language to "English-EN" when the widget is initialized
    _selectedLanguage = languages.indexOf('English-EN');
    defaultLanguage = languages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Language',
        icon: null,),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Default',
                    style: appBarLabel.copyWith(color: purple4, fontSize: 22),),
                SizedBox(height: 12,),
                Container(
                height: 70,
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
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('$defaultLanguage',
                              style: appBarLabel.copyWith(color: Colors.black, fontSize: 18),),
                          ],
                        ),
                      )),
                ),
                  SizedBox(height: 20,),
                  Text('Change Language',
                    style: appBarLabel.copyWith(color: purple4, fontSize: 22),),

                ],
              ),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 290,
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
                  child: Column(
                    children: [
                      for (int i = 0; i < languages.length; i++)
                        RadioListTile(
                          title: Text(languages[i],
                          style: appBarLabel.copyWith(
                            fontSize: 18, // Set your desired font size here
                            color: _selectedLanguage == i ? purple4 : Colors.black,
                            ),
                          ),
                          value: i,
                          activeColor: purple4,
                          groupValue: _selectedLanguage,
                          controlAffinity: ListTileControlAffinity.trailing, // Move the radio button to the rightmost
                          onChanged: (int? value) {
                            setState(() {
                              _selectedLanguage = value;
                              defaultLanguage = languages[_selectedLanguage!];
                              print('${languages[_selectedLanguage!]}');
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
