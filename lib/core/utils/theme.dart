import 'package:flutter/material.dart';

ThemeData lightTheme()=>ThemeData.light().copyWith(
  primaryColor:Colors.teal ,
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.teal,
      fillColor: Colors.grey,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.tealAccent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.teal, width: 5),
      ),
    ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.teal,),
  shadowColor: Colors.grey.shade300,
  appBarTheme: const AppBarTheme( color: Colors.white, iconTheme: IconThemeData(color: Colors.black,),centerTitle: true,titleTextStyle: TextStyle(color: Colors.black,fontSize: 20)),
  textTheme: const TextTheme(
      titleSmall:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,) ,
      bodyMedium: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 0.15,),
    titleMedium: TextStyle(color: Colors.black),
  ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      elevation: 20,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor:Colors.teal ,elevation:5 ,iconSize: 27,), colorScheme: const ColorScheme( brightness: Brightness.light, primary: Colors.white, onPrimary: Colors.white,
    secondary: Colors.white, onSecondary: Colors.white, error: Colors.red,
    onError: Colors.red, surface: Colors.white, onSurface: Colors.white, )
);


ThemeData darkTheme()=>ThemeData.dark().copyWith(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    suffixIconColor: Colors.red,
    fillColor: Colors.black26,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.red, width: 5),
    ),
  ),
    shadowColor: Colors.grey.shade300,
    appBarTheme: const AppBarTheme( color: Colors.black, iconTheme: IconThemeData(color: Colors.white),centerTitle: true,titleTextStyle: TextStyle(color: Colors.white,fontSize: 20)),
    textTheme: const TextTheme(
      titleSmall:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,) ,
      bodyMedium: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.15,),
      titleMedium: TextStyle(color: Colors.white),

    ),
  primaryColor:Colors.red ,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red,),
    colorScheme:  const ColorScheme( brightness: Brightness.light, primary: Colors.red, onPrimary: Colors.black,
        secondary: Colors.black, onSecondary: Colors.black, error: Colors.red,
        onError: Colors.red, surface: Colors.black, onSurface: Colors.black, ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation:5 ,iconSize: 27, ),
);