import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetectionView extends StatelessWidget {
  final File image; // El parámetro para pasar la imagen
  final Map<String, dynamic>? predictionResponse;

  DetectionView({required this.image, required this.predictionResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Detectión',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.only(left: 25.0),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
          
        ),
        Padding(
          padding: const EdgeInsets.symmetric( vertical:0.0),
          child: SizedBox(
            width: 350,
            height: 350,
            child: Image.file(
              image,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Moneda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Prediccion:${predictionResponse?["prediction"] ?? "N/A"}',
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w600),
              ),
            ))
          ],
        ),
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Predicción',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Porcentaje:${predictionResponse?["percetange"] ?? "N/A"}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ))
          ],
        ),
        const SizedBox(height: 10.0),
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 7.0,
          percent: 0.75,
          center: const Text(
            '75%',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          progressColor: const Color.fromARGB(255, 33, 134, 7),
        ),
        const SizedBox(height: 20.0),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
            child: Center(
              child: Text(
                'En base a la Imagen,se predice con un 95.91% de seguridad que el billete de 20 nuevos soles es Falso',
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
            )),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 60.0)),
            child: const Text('Guardar'),
          ),
        )
      ]),
    );
  }
}
