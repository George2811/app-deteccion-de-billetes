import 'package:counterfeit_detector/ui/services/prediction_service.dart';
import 'package:counterfeit_detector/ui/views/detection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:io';

class CameraFunctionalityView extends StatefulWidget {
  @override
  _CameraFunctionalityViewState createState() =>
      _CameraFunctionalityViewState();
}

class _CameraFunctionalityViewState extends State<CameraFunctionalityView> {
  String _imagePath = '';
  Map<String, dynamic>? _prediction;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Procesa o muestra la imagen tomada aquí.
    }
  }

 Future<void> _getImageFromGallery() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      _imagePath = pickedImage.path;
      _prediction = null;
    });

    try {
      var predictionResponse = await predictImage(pickedImage.path);

      setState(() {
        _prediction = predictionResponse;
      });

      File imageFile = File(pickedImage.path);
      _navigateToDetectionView(imageFile, _prediction);
    } catch (e) {
      print('Error predicting image: $e');
    }
  }
}


  Future<void> _predictImage(String imagePath) async {
    try {
      var predictionResponse = await predictImage(imagePath);

      setState(() {
        _prediction = predictionResponse;
      });
    } catch (e) {
      print('Error predicting image: $e');
    }
  }

  void _navigateToDetectionView(File imageFile,Map<String, dynamic>? predictionResponse) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetectionView(image: imageFile,predictionResponse: predictionResponse),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Detección",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.only(left: 25.0),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _getImageFromCamera,
          child: const Text('Seleccionar desde la cámara'),
        ),
        ElevatedButton(
          onPressed: _getImageFromGallery,
          child: const Text('Seleccionar desde la galería'),
        ),
        _imagePath.isNotEmpty
            ? Image.file(
                File(_imagePath),
                height: 350,
                width: 350,
              )
            : SizedBox.shrink(),
        if (_prediction != null)
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
                  'Prediccion:${_prediction?["prediction"] ?? "N/A"}',
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
                'Porcentaje:${_prediction?["percetange"] ?? "N/A"}',
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Guardar'),
          ),
        )
      ],
    ));
  }
}
