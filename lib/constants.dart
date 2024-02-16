import 'package:flutter/material.dart';

const purple1 = Color(0xFF910CCF);
const purple2 = Color(0xFFDA7BFC);
const purple3 = Color(0xFFC7B3E5);
const purple4 = Color(0xFF6615A6);
const purple5 = Color(0xFFE0D0F8);
const purple6 = Color(0xFFB8A6D3);
const purple7 = Color(0xFFB25BD0);
const backgroundColor = Color(0xFFECE4FA);
const backgroundColor2 = Color(0xFFFEFCF1);
const fontFamily = 'AoboshiOne';
const fontFamily2 = 'Quicksand';

const signUpTextStyle = TextStyle(
  fontFamily: fontFamily,
  color: purple1,
  fontSize: 10,
  fontWeight: FontWeight.w500,
);

const signUpButtonTextStyle = TextStyle(
  fontFamily: fontFamily,
  color: purple2,
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const pageTitleTextStyle =TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w400,
  fontFamily: fontFamily,
  color: purple1,
);

const kTextFieldLabelStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  fontFamily: fontFamily,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
      fontFamily: fontFamily2,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      fontSize: 16,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: purple3), // Set the underline color
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey), // Set the underline color when the field is focused
  ),
);

const appBarLabel =TextStyle(
  fontFamily: fontFamily,
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 12,
);

const appLabelTextStyle = TextStyle(
  color: purple4,
  fontFamily: fontFamily,
  fontSize: 18,
);

const textFieldStyle = InputDecoration(
contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
hintText: 'Type your message here',
hintStyle: TextStyle(
color: purple3,
fontSize: 13,
),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: purple3),
borderRadius: BorderRadius.all(Radius.circular(10.0)),
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: purple3),
borderRadius: BorderRadius.all(Radius.circular(10.0)),
),
);

final dropDownStyle = InputDecorationTheme(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
  constraints: const BoxConstraints.tightFor(height: 38),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: purple3, width: 2),
  ),
  // Use suffixIcon property to set the color of the suffix icon.
  suffixIconColor: purple3,
);




