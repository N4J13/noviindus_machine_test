import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all(Size.zero),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(
            double.infinity,
            50,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return AppColors.primaryColor;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xffdc271f),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      alignLabelWithHint: true,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color.fromARGB(102, 0, 0, 0),
      ),
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      filled: true,
      isCollapsed: true,
      fillColor: Color(0x3FD9D9D9),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(64, 217, 217, 217)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffdc271f)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffdc271f)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe5e7eb)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(150, 147, 147, 0)),
        // fully rounded border
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color.fromRGBO(0, 0, 0, 0.3),
      ),
    )),
    disabledColor: const Color.fromARGB(255, 147, 147, 148),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryColor,
      onPrimaryContainer: Colors.white,
      secondary: Colors.white,
      onSecondary: Color(0xff0e1524),
      secondaryContainer: AppColors.primaryColor,
      onSecondaryContainer: Colors.white,
      tertiary: Color.fromRGBO(0, 40, 252, 1),
      onTertiary: Colors.black,
      tertiaryContainer: Colors.amber,
      onTertiaryContainer: Colors.amber,
      background: Colors.white,
      onBackground: Color.fromARGB(255, 0, 21, 71),
      onError: Color(0xffdc271f),
      error: Color(0xffdc271f),
      errorContainer: Color.fromARGB(255, 252, 231, 233),
      onErrorContainer: Color(0xffdc271f),
      outline: Color(0xffe5e7eb),
    ),
    dialogBackgroundColor: Colors.white,
    dividerColor: const Color(0xffe5e7eb),
    dividerTheme: const DividerThemeData(
      color: Color(0xffe5e7eb),
    ),
    radioTheme: const RadioThemeData(),
    fontFamily: GoogleFonts.poppins().fontFamily,
    datePickerTheme: const DatePickerThemeData(
      weekdayStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff0e1524),
      ),
      dayStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff0e1524),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Color(0xff0e1524),
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff0e1524),
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
        color: Color.fromARGB(255, 0, 21, 71),
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(123, 0, 0, 0),
      ),
      displaySmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 20, 30, 52),
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xff404040),
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xffc1c4d2),
      ),
    ));
