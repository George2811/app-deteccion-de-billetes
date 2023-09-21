import 'dart:io';
import 'package:counterfeit_detector/services/detection_service.dart';
import 'package:counterfeit_detector/state/storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetectionView extends StatefulWidget {
  final File image; // El parámetro para pasar la imagen
  final Map<String, dynamic>? predictionResponse;
  final int currencyId;

  DetectionView({required this.image, required this.predictionResponse, required this.currencyId});

  @override
  State<DetectionView> createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  bool loading = false;

  Future<void> _saveDetection(BuildContext context, String classification, double percentage) async {
    setState(() {
      loading = true;
    });
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    var snackBar;
    try {
      String imageUrl = await StoreData().uploadImageStorage("banknotes", uniqueFileName, widget.image);
      var res = await saveDetection(widget.currencyId, classification, percentage, imageUrl);

      String msg = "Se guardó la detección correctamente.";
      snackBar = SnackBar(content: Text(msg, style: const TextStyle(color: Color.fromARGB(255, 22, 184, 49)),),backgroundColor: const Color.fromARGB(255, 0, 0, 0),);      
    } catch (e) {
      await StoreData().deleteImageStorage("banknotes", uniqueFileName);
      String msg = "Error saving the detection.";
      //print(msg);
      snackBar = SnackBar(content: Text(msg, style: const TextStyle(color: Color.fromARGB(255, 255, 81, 68)),),backgroundColor: const Color.fromARGB(255, 0, 0, 0),);
    }
    setState(() {
      loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // cambiar snackbar porque borra el bottom bar
  }

  String extractMoneda(String value) {
    final RegExp solesRegExp = RegExp(r'soles', caseSensitive: false);
    final RegExp dolaresRegExp = RegExp(r'dólares', caseSensitive: false);

    if (solesRegExp.hasMatch(value)) {
      return 'Soles';
    } else if (dolaresRegExp.hasMatch(value)) {
      return 'Dólares';
    } else {
      return '';
    }
  }

  String getVeracity(String value) {
    final RegExp falseRegExp = RegExp(r'falso', caseSensitive: false);
    if (falseRegExp.hasMatch(value)) {
      return 'Falso';
    } else {
      return 'Verdadero';
    }
  }

  String getMoneda() {
    if (widget.predictionResponse != null) {
      String prediction = widget.predictionResponse!["prediction"] ?? "";
      return extractMoneda(prediction);
    }
    return '';
  }

  String formatPercentage(Map<String, dynamic>? predictionResponse) {
    final double? percentage = predictionResponse?["percentage"];
    if (percentage != null) {
      final formattedPercentage = (percentage * 100).toStringAsFixed(2);
      return '$formattedPercentage%';
    }

    return '';
  }

  double percentageValue(Map<String, dynamic>? predictionResponse) {
    final double? percentage = predictionResponse?["percentage"];
    if (percentage != null) {
      return percentage;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    String moneda = getMoneda();
    String percentage = formatPercentage(widget.predictionResponse);
    double perValue = percentageValue(widget.predictionResponse);
    String veracity = getVeracity(widget.predictionResponse?["prediction"]);

    return Scaffold(
      body: Column(children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Detección',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () { Navigator.pop(context);},
            child: Container(
              margin: const EdgeInsets.only(left: 25.0),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: SizedBox(
            width: 300,
            height: 300,
            child: Image.file(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 110),
              width: 94,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black),
              child: const Text(
                'Moneda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Text(
              '${widget.predictionResponse?["prediction"] ?? "N/A"}',
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 110),
              width: 94,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black),
              child: const Text(
                'Predicción',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Text(
              veracity,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: veracity == 'Verdadero'
                      ? const Color.fromARGB(255, 33, 134, 7)
                      : const Color.fromARGB(255, 182, 33, 23)),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 7.0,
            percent: perValue,
            center: Text(
              percentage,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            progressColor: veracity == 'Verdadero'
                ? const Color.fromARGB(255, 33, 134, 7)
                : const Color.fromARGB(255, 182, 33, 23)),
        Padding(
            padding:const EdgeInsets.symmetric(horizontal: 40.0, vertical: 23.0),
            child: Center(
              child: Text(
                'En base a la imagen, se predice con un $percentage de seguridad que el billete es ${veracity.toLowerCase()}',
                style: const TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
            )),
        Center(
          child: loading?
          const SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(color: Color.fromARGB(255, 2, 33, 10), strokeWidth: 3)
          )
          :
          ElevatedButton(
            onPressed: (){
              if(!loading){
                _saveDetection(context, widget.predictionResponse?["prediction"], perValue);
              } else {
                print("Cargando...");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 2, 33, 10),
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 60.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        )
      ]),
    );
  }
}


// Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 90.0,right: 10.0, bottom: 3.0),
//               child: Container(
//                 padding: const EdgeInsets.only( left:8.0,right:22.0,bottom: 8.0,top: 8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.0),
//                   color: Colors.black
//                 ),
//                 child: const Text(
//                   'Moneda',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   moneda,
//                   style: const TextStyle(
//                       fontSize: 15.0, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.only(left: 90.0,right: 10.0, bottom: 3.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.0),
//                     color: Colors.black),
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Text(
//                   'Predicción',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 '${predictionResponse?["prediction"] ?? "N/A"}',
//                 //'Porcentaje:${predictionResponse?["percetange"] ?? "N/A"}',
//                 style:
//                     const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ))
//           ],
//         ),
//         const SizedBox(height: 10.0),
//         CircularPercentIndicator(
//           radius: 40.0,
//           lineWidth: 7.0,
//           percent: perValue,
//           center:  Text(
//             percentage,
//             style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//           ),
//           progressColor: const Color.fromARGB(255, 33, 134, 7),
//         ),
//         const SizedBox(height: 20.0),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 3.0),
//           child: Center(
//             child: Text(
//               'En base a la imagen, se predice con un $percentage de seguridad que el billete es $veracity',
//               style: const TextStyle(fontSize: 14.0, color: Colors.black54),
//             ),
//           )
//         ),
//         Center(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0)),
//                 padding: const EdgeInsets.symmetric(horizontal: 80.0)),
//             child: const Text('Guardar'),
//           ),
//         )
      