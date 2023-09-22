import 'package:flutter/material.dart';
import 'package:wanalearn/core/resources/colours.dart';
import 'package:wanalearn/core/resources/fonts.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: Fonts.poppins,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
    );
  }
}
