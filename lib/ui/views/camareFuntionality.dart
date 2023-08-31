import 'package:counterfeit_detector/ui/services/prediction_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraFunctionalityView extends StatefulWidget {
  @override
  _CameraFunctionalityViewState createState() => _CameraFunctionalityViewState();
}

class _CameraFunctionalityViewState extends State<CameraFunctionalityView> {
  String _imagePath='';
  Map<String,dynamic>?_prediction;
  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Procesa o muestra la imagen tomada aquí.
    }
  }


  Future<void> _getImageFromGallery() async {

    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath=pickedImage.path;
        _prediction=null;
      });
      _predictImage(_imagePath);
      
      // Procesa o muestra la imagen seleccionada de la galería aquí.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detección de Moneda"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _getImageFromCamera,
                  child: Text('Seleccionar desde la cámara'),
                ),
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: Text('Seleccionar desde la galería'),
                ),
                _imagePath.isNotEmpty
                ?Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                ):SizedBox.shrink(),
                if(_prediction!=null)
                Column(
                  children: [
                    Text('Prediccion:${_prediction!["prediction"]}',
                    style: TextStyle(fontSize: 18),
                    ),
                    Text('Porcentaje:${_prediction!["percetange"]}',
                    style: TextStyle(fontSize: 18),)
                    
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}

