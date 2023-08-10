import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 300,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              child: ClipRRect(
                // borderRadius: const BorderRadius.only(
                //   topLeft: Radius.circular(10.0),
                //   bottomLeft: Radius.circular(10.0),
                // ),
                child: Image.network(
                  "https://www.ipe.org.pe/portal/wp-content/uploads/2020/03/retiro-CTS-finanzas.jpg",
                  height: 100,
                  width: 150,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Soles",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Moneda Nacional del Perú",
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Image.asset(
                        "assets/peru_flag.png",
                        height: 20,
                        width: 30,
                      ),
                      const SizedBox(width: 4),
                      const Text("S/.", style: TextStyle(fontSize: 16)),
                      ],
                    )
                    ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
}