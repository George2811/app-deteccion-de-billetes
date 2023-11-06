import 'dart:io';
import 'package:counterfeit_detector/colors.dart';
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
  bool _isOpen = false;

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

 

  // String getVeracity(String value) {
  //   final RegExp falseRegExp = RegExp(r'falso', caseSensitive: false);
  //   if (falseRegExp.hasMatch(value)) {
  //     return 'Falso';
  //   } else {
  //     return 'Verdadero';
  //   }
  // }

  String getMoneda() {
    if (widget.predictionResponse != null) {
      String prediction = widget.predictionResponse!["value"] ?? "";
      return prediction;
    }
    return '';
  }

  String formatPercentage(double? percentage) {
    //final double? percentage = predictionResponse?["percentage"];
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
   dynamic getDetailValue(String detailKey, String? alternativeKey) {
    return widget.predictionResponse?["details"][detailKey] ?? widget.predictionResponse?["details"][alternativeKey];
  }

  @override
  Widget build(BuildContext context) {
    String moneda = getMoneda();
    String percentage = formatPercentage(widget.predictionResponse?["percentage"]);
    double perValue = percentageValue(widget.predictionResponse);
    //var edition = widget.predictionResponse?["edition"];
    String veracity = widget.predictionResponse?["prediction"];
    var details = widget.predictionResponse?["details"];
    var edition = details["numero_oculto"] != null? "2009": "2021";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
            height: 310,
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
                      height: 410,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 250,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        moneda,
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
              color: veracity == 'verdadero'
                  ? const Color.fromRGBO(32, 136, 103, 1)
                  : const Color.fromRGBO(217, 97, 100, 1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los elementos a la izquierda
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
                    child: Text('$percentage de veracidad',
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
          const SizedBox(height: 30.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 345,
              child: ExpansionPanelList(
                elevation: 0,
                children: [
                  ExpansionPanel(
                    backgroundColor: const Color.fromARGB(255, 240, 239, 239),
                    headerBuilder: (context, isOpen) {
                      return Container(
                        height: 50,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "Detalle",
                              style: TextStyle(
                                color: dark[300],
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Tooltip(
                              showDuration: const Duration(seconds: 8),
                              margin: const EdgeInsets.symmetric(horizontal: 50),
                              message: "Porcentajes de veracidad de cada elemento de seguridad tras el análisis del billete",
                              child: Container(
                                width: 20,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color.fromARGB(255, 194, 194, 194))
                                ),
                                child: Icon(
                                  Icons.question_mark_rounded,
                                  color: dark[100],
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    body: Container(
                      height: 230,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(       
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,                         
                                children: [
                                  Text(
                                    "Edición",
                                    style: TextStyle(
                                      color: dark[200],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Container(
                                    width: 48,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: dark,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        edition.toString(),
                                        style: TextStyle(
                                          color: dark[50],
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Marca de agua",
                                    style: TextStyle(
                                      color: dark[200],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    formatPercentage(details["marca_de_agua"]),
                                    style: TextStyle(
                                      color: dark[400],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Container(
                                width: 312,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value:details["marca_de_agua"],
                                    backgroundColor: dark[100],
                                    color: alternative[300],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Microimpresiones",
                                    style: TextStyle(
                                      color: dark[200],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    formatPercentage(details["microimpresiones"]),
                                    style: TextStyle(
                                      color: dark[400],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Container(
                                width: 312,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: details["microimpresiones"],
                                    backgroundColor: dark[100],
                                    color: alternative[300],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Hilo de seguridad",
                                    style: TextStyle(
                                      color: dark[200],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    formatPercentage(details["hilo_de_seguridad"]),
                                    style: TextStyle(
                                      color: dark[400],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Container(
                                width: 312,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: details["hilo_de_seguridad"],
                                    backgroundColor: dark[100],
                                    color: alternative[300],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    details["numero_oculto"] != null? "Número oculto": "Spark Live",
                                    style: TextStyle(
                                      color: dark[200],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    formatPercentage(getDetailValue("numero_oculto", "figuras_en_movimiento")),
                                    style: TextStyle(
                                      color: dark[400],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Container(
                                width: 312,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: details["numero_oculto"] ?? details["figuras_en_movimiento"],
                                    backgroundColor: dark[100],
                                    color: alternative[300],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ),
                    isExpanded: _isOpen,
                  ),
                ],
                expansionCallback: (i, isOpen) => setState(() =>
                
                _isOpen = !_isOpen
               

                ),
              ),
            ), 
          ),
          const SizedBox(height: 30.0),
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
                            widget.predictionResponse?["value"], perValue);
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
          ),
          const SizedBox(height: 60.0),
        ]),
      ),
    );
  }
}
