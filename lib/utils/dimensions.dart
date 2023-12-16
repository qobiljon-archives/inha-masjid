import 'package:flutter/widgets.dart';

class AppDimensions {
  // Private constructor to prevent instances from this class
  AppDimensions._();

  // Dimensions (primarily from figma UI)
  // https://www.figma.com/file/sflifKnmkstz8j02emIXMS/Inha-Masjid-draft-(work-on-this)?type=design&node-id=0%3A1&mode=design&t=UmlmHZfCo964xBvV-1

  // 172x80 logo in 393x852 container
  static const double splashLogoFactor = 172 / 393;

  // 48.8x60.22 logo in 393x852 container
  static const double welcomeLogoFactor = 48.8 / 393;

  // 329x329 square image in 393x393 container
  static const double welcomeImageFactor = 329 / 393;

  // 168x56 button in 393x852 container
  static const double welcomeButtonWidth = 168 / 393;
  static const double welcomeButtonHeight = 56 / 852;
}
