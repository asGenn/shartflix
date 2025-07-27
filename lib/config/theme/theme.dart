import "package:flutter/material.dart";

class AppTheme {
  static const Color primaryRed = Color(0xffE50914);
  static const Color backgroundColor = Color(0xff000000);
  static const Color surfaceColor = Color(0xff1a1a1a);
  static const Color textColor = Color(0xffffffff);
  static const Color greyColor = Color(0xff8C8C8C);
  static const Color darkSurfaceColor = Color(0xff090909);
  static const Color darkRed = Color(0xff6F060B);
  static const Color lightRed = Color(0xffE50914);
  static const Color lightBlue = Color(0xff5949E6);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryRed,
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: primaryRed,
        onPrimary: Colors.white,
        secondary: Colors.grey,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      fontFamily: 'Euclid Circular A',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontFamily: 'Euclid Circular A',
        ),
        displayMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        displaySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        titleMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'Euclid Circular A',
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'Euclid Circular A',
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryRed,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: backgroundColor),
      colorScheme: const ColorScheme.dark(
        primary: primaryRed,
        onPrimary: Colors.white,
        secondary: greyColor,
        onSecondary: Colors.white,
        surface: surfaceColor,
        onSurface: textColor,
      ),
      fontFamily: 'Euclid Circular A',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontFamily: 'Euclid Circular A',
        ),
        displayMedium: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        displaySmall: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        headlineLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
        ),
        titleMedium: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Euclid Circular A',
        ),
        bodyMedium: TextStyle(
          color: greyColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Euclid Circular A',
        ),
        labelLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Euclid Circular A',
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: const TextStyle(color: greyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
