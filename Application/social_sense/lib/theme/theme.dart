import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      surfaceTintColor: Colors.black),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    background: Colors.black,
    onBackground: Colors.white,
    surfaceTint: Colors.black12,
    onPrimary: Colors.black,
    primary: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.black,
      ),
    ),
  ),
);
