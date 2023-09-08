import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetectionView extends StatelessWidget {
  final File image; // El parámetro para pasar la imagen
  final Map<String, dynamic>? predictionResponse;

  DetectionView({required this.image, required this.predictionResponse});

  String extractMoneda(String value) {
    final RegExp solesRegExp = RegExp(r'soles', caseSensitive: false);
    final RegExp dolaresRegExp = RegExp(r'dólares', caseSensitive: false);

    if (solesRegExp.hasMatch(value)) {
      return 'soles';
    } else if (dolaresRegExp.hasMatch(value)) {
      return 'dólares';
    } else {
      return '';
    }
  }


String getMoneda() {
    if (predictionResponse != null) {
      String prediction = predictionResponse!["prediction"] ?? "";
      return extractMoneda(prediction);
    }
    return '';
  }

  String formatPercentage(Map<String, dynamic>? predictionResponse) {
  final double? percentage = predictionResponse?["percetange"];
  if (percentage != null) {
    final formattedPercentage = (percentage * 100).toStringAsFixed(2);
    return '%$formattedPercentage';
  }
  
  return '';
}
 double percentageValue(Map<String,dynamic>? predictionResponse){
  final double? percentage=predictionResponse?["percetange"];
  if(percentage!=null){
    return percentage;
  }
  return 0.0;

 }


  @override
  Widget build(BuildContext context) {
    String moneda = getMoneda();
    String percentage=formatPercentage(predictionResponse);
    double perValue=percentageValue(predictionResponse);


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
                  const EdgeInsets.only(left: 90.0,right: 10.0, bottom: 3.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                padding: const EdgeInsets.only( left:8.0,right:22.0,bottom: 8.0,top: 8.0),
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
                moneda,
                //'Prediccion:${predictionResponse?["prediction"] ?? "N/A"}',
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
                  const EdgeInsets.only(left: 90.0,right: 10.0, bottom: 3.0),
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
                '${predictionResponse?["prediction"] ?? "N/A"}',
                //'Porcentaje:${predictionResponse?["percetange"] ?? "N/A"}',
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
          percent: perValue,
          center:  Text(
            percentage,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          progressColor: const Color.fromARGB(255, 33, 134, 7),
        ),
        const SizedBox(height: 20.0),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 3.0),
            child: Center(
              child: Text(
                'En base a la Imagen,se predice con un $percentage de seguridad que el billete de ${predictionResponse?["prediction"] ?? "N/A"} ',
                style: const TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
            )),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 80.0)),
            child: const Text('Guardar'),
          ),
        )
      ]),
    );
  }
}