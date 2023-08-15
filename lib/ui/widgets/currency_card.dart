import 'package:counterfeit_detector/ui/views/characteristics.dart';
import 'package:counterfeit_detector/ui/views/guide.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? img;
  final String? flag;
  final String? symbol;

  const CurrencyCard({Key? key, this.title, this.description, this.img, this.flag, this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: (){
          // Función para redirigirlos a la vista Guía (hay BUG)
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CharacteristicsView()));
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: Image.asset(
                  img?? "https://www.ipe.org.pe/portal/wp-content/uploads/2020/03/retiro-CTS-finanzas.jpg",
                  height: 100,
                  width: 150,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title?? "Título",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        description?? "Descripción",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           Image.asset(
                          flag?? "assets/peru_flag.png",
                          height: 20,
                          width: 30,
                        ),
                        const SizedBox(width: 4),
                        Text(symbol?? ":)", style: const TextStyle(fontSize: 16)),
                        ],
                      )
                      ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
}