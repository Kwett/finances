import 'package:flutter/material.dart';

class ThemeConfig {
  static final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
    ),
  );
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  static const TextStyle dropdownStyle = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 20,
    color: Colors.white,
  );

  static const TextStyle basicStyle = TextStyle(
    fontFamily: 'Mplus',
    fontWeight: FontWeight.w900,
    fontSize: 14,
    color: Colors.black, 
  );

  static const TextStyle recapStyle = TextStyle(
    fontFamily: 'Magra',
    fontSize: 18,
    color: Colors.black,
  );

  static const TextStyle dateStyle = TextStyle(
    fontFamily: 'Neuton',
    fontSize: 16,
    color: Color.fromARGB(226, 255, 255, 255)
  );
}
