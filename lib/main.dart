import 'package:flutter/material.dart';
import 'package:task_manager/screens/login_signup/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Task',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Color.fromARGB(255, 231, 240, 241),

        appBarTheme: AppBarThemeData(
          backgroundColor: Color.fromARGB(255, 231, 240, 241),
          elevation: 0,
        ),

        cardTheme: CardThemeData(color: Colors.white, elevation: 0),

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          border: OutlineInputBorder(
            borderSide: .none,
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.red),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.teal),

            borderRadius: BorderRadius.circular(12),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.teal,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.zero,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(),
      ),

      home: SplashScreen(),
    );
  }
}
