import 'package:flutter/material.dart';

class AppTheme{
  // Primary Color Schemes
  static const Color marsRed = Color.fromARGB(255, 206, 20, 20);
  static const Color marsOrange = Color.fromARGB(255, 255, 128, 0);
  static const Color marsBlack = Color.fromARGB(255, 27, 27, 27);
  static const Color marsGrey = Color.fromARGB(255, 65, 65, 65);
  static const Color marsWhite = Color.fromARGB(255, 255, 255, 255);

  // Custom Text styles
    // Text for light theme 
  static const TextTheme lightTextTheme = TextTheme(
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 18.0, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 20.0, color: Colors.white),
    
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

    // Text for dark theme
  static const TextTheme darkTextTheme = TextTheme(
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 20.0, color: Colors.black),
    
    displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,//black
    ),
  );

  // Shared properties across all screens
  static final ThemeData marsDarkTheme = ThemeData( // marsTheme cannot be re-assigned 
    brightness: Brightness.dark,
    scaffoldBackgroundColor: marsBlack,
    colorScheme: ColorScheme.dark(
      primary: marsRed, 
      secondary: marsOrange,
      surface: marsBlack, // Background Color
    ),
    textTheme: lightTextTheme,
  );

  static final ThemeData marsLightTheme = ThemeData( // marsTheme cannot be re-assigned 
    brightness: Brightness.light,
    scaffoldBackgroundColor: marsWhite,
    colorScheme: ColorScheme.light(
      primary: marsRed, 
      secondary: marsOrange,
      surface: marsBlack, // Background Color
    ),
    textTheme: darkTextTheme,
  );
}


