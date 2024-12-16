import 'package:flutter/material.dart';
import 'dart:ui';


import 'colors.dart';

class MTTextStyle {
  static const double fontSize15 = 15.0;
  static const double fontSize20 = 20.0;
  static const double fontSize25 = 25.0;
  static const double fontSize30 = 30.0;
  static const double fontSize35 = 35.0;

  static TextStyle CoalColorText25 = const TextStyle(
      color: UIColors.coal,
      fontSize: fontSize25,
      fontWeight: FontWeight.bold);

  static const TextStyle HintText15 = TextStyle(
      color: UIColors.coal10,
      fontSize: fontSize25,
      fontWeight: FontWeight.w400);

  static const TextStyle formFieldStyle = TextStyle(
    decoration: TextDecoration.none,
    fontSize: 14,

    fontVariations: [
      FontVariation('wght', 700),
      FontVariation('wdth', 100),
    ],);

  static const TextStyle splashScreenStyle = TextStyle(
    decoration: TextDecoration.none,
    fontSize: 40,
    color: Colors.white,
    fontVariations: [
      FontVariation('wght', 700),
      FontVariation('wdth', 100),
    ],);
}