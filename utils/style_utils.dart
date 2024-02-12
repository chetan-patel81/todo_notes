import 'dart:ui';


import 'package:flutter/material.dart';

class MyAppStyle {
  

  static TextStyle headStyle(color) {
    return TextStyle(
      
      fontSize: 34.0,
      fontWeight: FontWeight.bold, color: color,
      // color: MyAppTheme.darkColor,
    );
  }

  static TextStyle hintStyle(color) {
    return TextStyle(
  
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      // color: MyAppTheme.greyColor,
      color: color,
    );
  }

  static TextStyle titleStyle(color) {
    return TextStyle(
      
      fontSize: 14.0,
      fontWeight: FontWeight.w500, color: color,
      // color: MyAppTheme.darkColor,
    );
  }

  static TextStyle btnStyle(color) {
    return TextStyle(

      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: color,
      // color: MyAppTheme.lightColor,
    );
  }
  
}
