import 'package:counterfeit_detector/services/prediction_service.dart';
import 'package:counterfeit_detector/ui/views/detection.dart';
import 'package:counterfeit_detector/ui/views/select_currency.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:counterfeit_detector/state/appdata.dart';
import 'dart:io';

class CameraFunctionalityView extends StatefulWidget {
  final int currencyId;
  const CameraFunctionalityView({super.key, this.currencyId = 0});

  @override
  State<CameraFunctionalityView> createState() =>
      _CameraFunctionalityViewState();
}

class _CameraFunctionalityViewState extends State<CameraFunctionalityView> {
  String _imagePath = '';
  bool isLoading = false;
  Map<String, dynamic>? _prediction;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        isLoading = true;
        _imagePath = pickedImage.path;
        _prediction = null;
      });

      try {
        var predictionResponse = await predictImage(pickedImage.path);

        setState(() {
          appData.showNavBar = false;
          isLoading = false;
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
        isLoading = true;
        _imagePath = pickedImage.path;
        _prediction = null;
      });

      try {
        var predictionResponse = await predictImage(pickedImage.path);

        setState(() {
          _prediction = predictionResponse;
          isLoading = false;
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

  void _navigateToDetectionView(
      File imageFile, Map<String, dynamic>? predictionResponse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetectionView(
            image: imageFile, predictionResponse: predictionResponse, currencyId:  widget.currencyId,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Detección",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SelectCurrency()));},
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
                width: 300,
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: const Text(
                  "Favor, selecciona el método de detección",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {
                    _getImageFromCamera();
                  },
                  child: Container(
                    height: 160,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: const AssetImage("assets/camera.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Cámara',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {
                    _getImageFromGallery();
                  },
                  child: Container(
                    height: 160,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: const AssetImage("assets/gallery.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Galería',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {},
                  child: Container(
                    height: 160,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: const AssetImage("assets/scanner.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Scanner (Próximamente)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      const BoxDecoration(color: Color.fromARGB(193, 0, 0, 0)),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Color.fromARGB(255, 29, 214, 38),
                          strokeWidth: 4,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Analizando billete...",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    ));
  }
}
