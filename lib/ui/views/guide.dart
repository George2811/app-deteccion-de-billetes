import 'package:counterfeit_detector/ui/widgets/currency_card.dart';
import 'package:flutter/material.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Guía",
              style: TextStyle(
                color: Colors.black54,
                fontWeight:  FontWeight.bold 
              ),
            ),
            automaticallyImplyLeading: false,
            leading: Container(
              margin: const EdgeInsets.only(left: 25.0),
              child: const Icon(
                Icons.menu,
                color: Colors.black54,
              )
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: const Text(
              "Aquí encontrarás las características de seguridad de los billetes",
              style: TextStyle(
                color: Colors.black54,
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
      )
    );
  }
}
