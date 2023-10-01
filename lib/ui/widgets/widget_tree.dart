import 'package:counterfeit_detector/state/auth.dart';
import 'package:counterfeit_detector/ui/views/control.dart';
import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const ControlView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}