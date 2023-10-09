import 'package:flutter/material.dart';

// Primary Color (500)
const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE1FDEE),
  100: Color(0xFFB4FAD4),
  200: Color(0xFF83F7B7),
  300: Color(0xFF51F49A),
  400: Color(0xFF2BF185),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF05ED67),
  700: Color(0xFF04EB5C),
  800: Color(0xFF03E852),
  900: Color(0xFF02E440),
});
const int _primaryPrimaryValue = 0xFF06EF6F;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFA5FFB8),
  700: Color(0xFF8BFFA4),
});
const int _primaryAccentValue = 0xFFD8FFE0;

// Alternative Color (500)
const MaterialColor alternative = MaterialColor(_alternativePrimaryValue, <int, Color>{
  50: Color(0xFFE1F9EC),
  100: Color(0xFFB3F0D0),
  200: Color(0xFF80E6B0),
  300: Color(0xFF4DDB90),
  400: Color(0xFF27D479),
  500: Color(_alternativePrimaryValue),
  600: Color(0xFF01C759),
  700: Color(0xFF01C04F),
  800: Color(0xFF01B945),
  900: Color(0xFF00AD33),
});
const int _alternativePrimaryValue = 0xFF01CC61;

const MaterialColor alternativeAccent = MaterialColor(_alternativeAccentValue, <int, Color>{
  100: Color(0xFFD7FFE0),
  200: Color(_alternativeAccentValue),
  400: Color(0xFF71FF90),
  700: Color(0xFF58FF7D),
});
const int _alternativeAccentValue = 0xFFA4FFB8;

// Secondary Color (500)
const MaterialColor secondary = MaterialColor(_secondaryPrimaryValue, <int, Color>{
  50: Color(0xFFE2FCF5),
  100: Color(0xFFB6F7E5),
  200: Color(0xFF85F1D4),
  300: Color(0xFF54EBC3),
  400: Color(0xFF30E7B6),
  500: Color(_secondaryPrimaryValue),
  600: Color(0xFF0AE0A2),
  700: Color(0xFF08DC98),
  800: Color(0xFF06D88F),
  900: Color(0xFF03D07E),
});
const int _secondaryPrimaryValue = 0xFF0BE3A9;

const MaterialColor secondaryAccent = MaterialColor(_secondaryAccentValue, <int, Color>{
  100: Color(0xFFF8FFFC),
  200: Color(_secondaryAccentValue),
  400: Color(0xFF92FFCF),
  700: Color(0xFF79FFC3),
});
const int _secondaryAccentValue = 0xFFC5FFE5;

// Dark Color (500)
const MaterialColor dark = MaterialColor(_darkPrimaryValue, <int, Color>{
  50: Color(0xFFE3E3E5),
  100: Color(0xFFBABABD),
  200: Color(0xFF8C8C91),
  300: Color(0xFF5E5E65),
  400: Color(0xFF3C3C44),
  500: Color(_darkPrimaryValue),
  600: Color(0xFF16161F),
  700: Color(0xFF12121A),
  800: Color(0xFF0E0E15),
  900: Color(0xFF08080C),
});
const int _darkPrimaryValue = 0xFF191923;

const MaterialColor darkAccent = MaterialColor(_darkAccentValue, <int, Color>{
  100: Color(0xFF5252FF),
  200: Color(_darkAccentValue),
  400: Color(0xFF0000EB),
  700: Color(0xFF0000D1),
});
const int _darkAccentValue = 0xFF1F1FFF;