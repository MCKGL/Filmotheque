import 'package:filmotheque/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filmothèque',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colours.ratingColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colours.btnColor),
          ),
        ),
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const LoginScreen(),
    );
  }
}