import 'package:counterfeit_detector/ui/views/characteristics.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? img;
  final String? flag;
  final String? symbol;

  const CurrencyCard({Key? key, this.title="Titulo", this.description, this.img, this.flag, this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEEFFF6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: (){
          // Función para redirigirlos a la vista Guía (hay BUG)
          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacteristicsView(category: title,)));
        },
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: 300,
          height: 120,
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
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description?? "Descripción",
                        style: const TextStyle(fontSize: 14),
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
                        Text(symbol?? ":)", style: const TextStyle(fontSize: 14)),
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