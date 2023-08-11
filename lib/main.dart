import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:flutter/material.dart';
//import 'package:counterfeit_detector/ui/widgets/bottom_navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //home: BottomNavBar(),
      home: LoginView(),
    );
  }
}
