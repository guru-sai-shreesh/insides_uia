import 'package:flutter/material.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';

class AppThemeData {
  static ThemeData getTheme (){
    return ThemeData(
      //main colours
      primarySwatch: ColourManager.cyan,
      primaryColor: ColourManager.grey_50,


      // scaffoldBackgroundColor: ColourManager.cyan_100,
      fontFamily: FontConst.fontFamily,
    );
  }
}