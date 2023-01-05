import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConst {
  static String fontFamily = GoogleFonts.openSans().fontFamily.toString();
}

class FontWeightManager {
  static const FontWeight mediumBold = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSizeManager {
  static const double f_10 = 10.0;
  static const double f_12 = 12.0;
  static const double f_14 = 14.0;
  static const double f_20 = 20.0;
  static const double f_22 = 22.0;
  static const double f_25 = 25.0;
}