import 'dart:ui';


import 'package:flutter/material.dart';

class MyAppStyle {
  static const String fontFamily = "metropolis";

  static TextStyle headStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 34.0,
      fontWeight: FontWeight.bold, color: color,
      // color: MyAppTheme.darkColor,
    );
  }

  static TextStyle hintStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      // color: MyAppTheme.greyColor,
      color: color,
    );
  }

  static TextStyle titleStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w500, color: color,
      // color: MyAppTheme.darkColor,
    );
  }

  static TextStyle btnStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: color,
      // color: MyAppTheme.lightColor,
    );
  }
  static TextStyle nameStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: color,
      // color: MyAppTheme.lightColor,
    );
  }



  static TextStyle bigShadowStyle(color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      color: color,
      shadows: const [
        Shadow(
          color: Colors.black,
          offset: Offset(4, 08),
          blurRadius: 4,
        ),
      ],
      // color: MyAppTheme.lightColor,
    );
  }
}
