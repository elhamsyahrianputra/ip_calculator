import 'package:flutter/material.dart';

const redColor1 = Color(0xFFF47961);
const redColor2 = Color(0xFFEA4F30);
const redColor3 = Color(0xFFD72F0F);

const greenColor1 = Color(0xFF35df90);
const greenColor2 = Color(0xFF1eb971);
const greenColor3 = Color(0xFF188f57);

const yellowColor1 = Color(0xFFfac661);
const yellowColor2 = Color(0xFFf1ae2d);
const yellowColor3 = Color(0xFFe49807);

const blueColor1 = Color(0xFF33a9ff);
const blueColor2 = Color(0xFF0090f7);
const blueColor3 = Color(0xFF0071c2);

const foregroundColor1 = Color(0xFF2f4765);
const foregroundColor2 = Color(0xFF2a405b);
const foregroundColor3 = Color(0xFF253850);
const foregroundColor4 = Color(0xFF203145);
const foregroundColor5 = Color(0xFF1c2a3b);

const backgroundColor1 = Color(0xFF172331);
const backgroundColor2 = Color(0xFF141e2c);
const backgroundColor3 = Color(0xFF131e2a);

const backgroundColor = Color(0xFF0E0F20);
const foregroundColor = Color(0xFF191A35);
const textColor = Color(0xFF000000);
const whiteColor = Color(0xFFffffff);

// Text Style
const textStyle = TextStyle(
  fontFamily: 'HindSiligary',
  color: whiteColor,
  fontSize: 16,
);
const keyTextStyle = TextStyle(
  fontFamily: 'HindSiligary',
  color: whiteColor,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
const titleStyle = TextStyle(
  color: whiteColor,
  fontSize: 20,
  fontWeight: FontWeight.w700,
  fontFamily: 'HindSiligary',
);

const inputTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 22,
  fontWeight: FontWeight.w600,
  fontFamily: 'HindSiligary',
);

const double borderWidth = 3;
const inputPadding = EdgeInsets.symmetric(horizontal: 2);

const cursorColor = Color(0xFFFFFFFF);
const enabledBorderColor = foregroundColor1;
const focusedBorderColor = Color(0xFFFFFFFF);
const disabledBorderColor = Colors.transparent;

// Input Counter Style
const double inputCounterSize = 40;
const inputCounterColor = Color(0xFFFFFFFF);

// Componen Style
ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(50),
  backgroundColor: yellowColor3,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
);

const dotStyle = TextStyle(
    color: Color(0xFFFFFFFF), fontSize: 60, fontFamily: 'HindSiligary');

const prefixStyle = TextStyle(
  textBaseline: TextBaseline.alphabetic,
  color: Color(0xFFFFFFFF),
  fontSize: 30,
);
