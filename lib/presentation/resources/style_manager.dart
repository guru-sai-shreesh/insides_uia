import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/presentation/resources/value_manager.dart';


TextStyle _getTextStyle (double fontSize, FontWeight fontWeight, Color colour){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: colour,

    fontFamily: FontConst.fontFamily,
  );

}

//regular
TextStyle getRegularStyle ({double fontSize = FontSizeManager.f_14, Color colour = ColourManager.black}){
  return _getTextStyle(
    fontSize,
    FontWeightManager.mediumBold,
    colour,
  );
}

//medium bold
TextStyle getMediumBoldStyle ({double fontSize = FontSizeManager.f_14, Color colour = ColourManager.black}){
  return _getTextStyle(
    fontSize,
    FontWeightManager.mediumBold,
    colour,
  );
}

//semi bold
TextStyle getSemiBoldStyle ({double fontSize = FontSizeManager.f_14, Color colour = ColourManager.black}){
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    colour,
  );
}

//bold
TextStyle getBoldStyle ({double fontSize = FontSizeManager.f_14, Color colour = ColourManager.black}){
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    colour,
  );
}