import 'package:counterfeit_detector/ui/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: BottomNavBar(),
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 1, 24, 7),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 1, 24, 7)),
          suffixIconColor: Color.fromARGB(255, 1, 24, 7),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
