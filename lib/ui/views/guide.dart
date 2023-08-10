import 'package:counterfeit_detector/ui/widgets/currency_card.dart';
import 'package:counterfeit_detector/ui/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TopBar(),
          CurrencyCard(title: "Soles", description: "Moneda Nacional del Perú", img: "assets/peru_flag.png", symbol: "S/."),
          CurrencyCard(title: "Dólares", description: "Moneda Oficial de los Estados Unidos", img: "assets/usa_flag.png", symbol: "\$"),
        ]
      )
    );
  }
}
