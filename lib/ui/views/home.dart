import 'package:counterfeit_detector/ui/widgets/currency_card.dart';
import 'package:counterfeit_detector/ui/widgets/detection_card.dart';
import 'package:counterfeit_detector/ui/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const TopBar(),
          const DetectionCard(),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            alignment: Alignment.centerLeft,
            width: 300,
            child: const Text(
              "Guías",
              style: TextStyle(
                color: Color.fromARGB(255, 2, 38, 12),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 14, 0, 16),
            alignment: Alignment.centerLeft,
            width: 300,
            child: const Text(
              "Aquí encontrarás las características de seguridad de los billetes",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const CurrencyCard(
            title: "Soles",
            description: "Moneda Nacional del Perú",
            img: "assets/soles.jpg",
            flag: "assets/peru_flag.png",
            symbol: "S/"
          ),
          const SizedBox(height: 14),
          const CurrencyCard(
            title: "Dólares",
            description: "Moneda Oficial de los Estados Unidos",
            img: "assets/dollars.jpg",
            flag: "assets/usa_flag.png",
            symbol: "\$"
          ),
        ]
      ),
    );
  }
}
