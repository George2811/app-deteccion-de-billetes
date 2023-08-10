import 'package:counterfeit_detector/ui/widgets/currency_card.dart';
import 'package:counterfeit_detector/ui/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TopBar(),
          CurrencyCard(),
          CurrencyCard(),
        ]
      )
    );
  }
}
