import 'package:counterfeit_detector/colors.dart';
import 'package:counterfeit_detector/ui/views/select_currency.dart';
import 'package:flutter/material.dart';

class DetectionCover extends StatelessWidget {
  const DetectionCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.center,
            end: Alignment.centerRight,
            stops: [0.1, 1],
            colors: [dark, Colors.transparent],
          )
        ),
        width: 300,
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              height: 200,
              width: 170,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Detector de billetes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Detecta la veracidad de tus billetes.",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: alternative,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      onPressed: () {
                        // LOS REDIRIGE A LA FUNCIONALIDAD DE DETECCIÓN DE BILLETES
                        //  1. Se aprueban permisos de cámara
                        //  2. Selecciona si es detección de Soles o Dólares
                        //  3. Un mensaje de como funciona?
                        //  4. Se activa la cámara :)
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectCurrency()));
                      },
                      icon: const Icon(
                        Icons.compare,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      label: const Text('Empezar', style: TextStyle(color: Colors.white,),),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    "assets/portrait.jpg",
                    height: 200,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                // TODO: Gradiente de la imagen en la card principal (Detector de billetes)
                // Container(
                //   height: 200.0,
                //   decoration: BoxDecoration(
                //     color: Colors.amber,
                //     gradient: LinearGradient(
                //       begin: FractionalOffset.centerLeft,
                //       end: FractionalOffset.centerRight,
                //       colors: [
                //         Colors.red,
                //         Color.fromARGB(255, 127, 5, 138).withOpacity(0.0),
                //       ],
                //       stops: const [
                //         0.5,
                //         0.9
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}