import 'dart:io';
import 'package:counterfeit_detector/services/detection_service.dart';
import 'package:counterfeit_detector/state/storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetectionView extends StatefulWidget {
  final File image; // El parámetro para pasar la imagen
  final Map<String, dynamic>? predictionResponse;
  final int currencyId;

  DetectionView(
      {required this.image,
      required this.predictionResponse,
      required this.currencyId});

  @override
  State<DetectionView> createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  bool loading = false;

  Future<void> _saveDetection(
      BuildContext context, String classification, double percentage) async {
    setState(() {
      loading = true;
    });
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    var snackBar;
    try {
      String imageUrl = await StoreData()
          .uploadImageStorage("banknotes", uniqueFileName, widget.image);
      var res = await saveDetection(
          widget.currencyId, classification, percentage, imageUrl);
      String msg = "Se guardó la detección correctamente.";
      snackBar = SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Color.fromARGB(255, 22, 184, 49)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      );
    } catch (e) {
      await StoreData().deleteImageStorage("banknotes", uniqueFileName);
      String msg = "Error saving the detection.";
      //print(msg);
      snackBar = SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Color.fromARGB(255, 255, 81, 68)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      );
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
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 25.0),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        Container(
          width: 345,
          height: 470,
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Image.file(
                    widget.image,
                    width: 345,
                    height: 470,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 410,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.predictionResponse?["prediction"] ?? "N/A"}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 0.0),
        Container(
          width: 345,
          height: 96,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: veracity == 'Verdadero'
                ? const Color.fromRGBO(32, 136, 103, 1)
                : const Color.fromRGBO(217, 97, 100, 1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinea los elementos a la izquierda

            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only ( top: 20,bottom: 5,left: 15
                      ),
                  child: Text('Potencialmente $veracity',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                  child: Text('$percentage de seguridad',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          child: loading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 2, 33, 10), strokeWidth: 3))
              : ElevatedButton(
                  onPressed: () {
                    if (!loading) {
                      _saveDetection(context,
                          widget.predictionResponse?["prediction"], perValue);
                    } else {
                      print("Cargando...");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 204, 97),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 140.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
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
