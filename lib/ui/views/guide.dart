import 'package:counterfeit_detector/ui/widgets/currency_card.dart';
import 'package:flutter/material.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                "Aquí encontrarás las características de seguridad de los billetes.",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            const CurrencyCard(
              title: "Soles",
              description: "Moneda Nacional del Perú",
              img: "assets/soles-card.jpg",
              flag: "assets/peru_flag.png",
              symbol: "S/"
            ),
            const SizedBox(height: 14),
            const CurrencyCard(
              title: "Dólares",
              description: "Moneda Oficial de los Estados Unidos",
              img: "assets/portrait.jpg",
              flag: "assets/usa_flag.png",
              symbol: "\$"
            ),
            Container(
              height: 300,
              width: 300,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              child: const Text(
                "Información obtenida gracias al BCRP y al U.S Currency Education Program.",
                style: TextStyle(
                  color: Color.fromARGB(137, 22, 22, 22),
                  fontStyle: FontStyle.italic,
                  fontSize: 12
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}
