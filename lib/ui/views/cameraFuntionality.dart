import 'package:counterfeit_detector/services/prediction_service.dart';
import 'package:counterfeit_detector/ui/views/detection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraFunctionalityView extends StatefulWidget {
  const CameraFunctionalityView({super.key});

  @override
  State<CameraFunctionalityView> createState() => _CameraFunctionalityViewState();
}

class _CameraFunctionalityViewState extends State<CameraFunctionalityView> {
  String _imagePath = '';
  Map<String, dynamic>? _prediction;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

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
      ],
    ));
  }
}