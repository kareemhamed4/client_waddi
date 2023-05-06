import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:waddy_app/buildMaterialColor.dart';
import 'package:waddy_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: buildMaterialColor(myFavColor),
  primaryColor: myFavColor,
  colorScheme: ColorScheme.light(primary: myFavColor),
  scaffoldBackgroundColor: myFavColor7,
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        color: myFavColor,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    color: myFavColor7,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: "Baloo2-Medium",
      fontSize: 24.0,
      color: myFavColor2,
    ),
    iconTheme: IconThemeData(color: myFavColor2),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: myFavColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myFavColor,
    unselectedItemColor: myFavColor4,
    backgroundColor: myFavColor5,
    elevation: 0,
    selectedLabelStyle:
        const TextStyle(fontFamily: "Baloo2-Bold", fontSize: 12),
    unselectedLabelStyle:
        const TextStyle(fontFamily: "Baloo2-Bold", fontSize: 12),
  ),
  textTheme: TextTheme(
    bodySmall:
        TextStyle(fontFamily: "Baloo2-Regular", color: myFavColor4), //caption
    bodyMedium:
        TextStyle(fontFamily: "Baloo2-Regular", color: myFavColor8), //bodyText2
    bodyLarge:
        TextStyle(fontFamily: "Baloo2-Medium", color: myFavColor8), //bodyText1
    titleSmall: TextStyle(
      fontFamily: "Baloo2-Medium",
      color: myFavColor8,
      fontSize: 24,
    ), //subtitle2
    titleMedium: TextStyle(
      fontFamily: "Baloo2-Medium",
      color: myFavColor8,
      fontSize: 27,
    ), //subtitle1
    titleLarge: TextStyle(
        fontFamily: "Baloo2-Medium",
        color: myFavColor8,
        fontSize: 48,
        height: 1.2), //headline5
    headlineMedium:
        TextStyle(fontFamily: "Baloo2-Medium", color: myFavColor8), //headline3
    labelLarge: TextStyle(
        fontFamily: "Baloo2-Bold", color: myFavColor7, fontSize: 20), //label
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('343232'),
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('343232'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.0,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('343232'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myFavColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: HexColor('343232'),
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
);
