import 'dart:convert';
import 'package:counterfeit_detector/state/auth.dart';
import 'package:counterfeit_detector/state/storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> saveDetection(
  int currencyId,
  String classification,
  double percentage,
  String imageUrl
  ) async {

  var url = Uri.parse('http://safycash-api.aadac9d6h9ccgtdz.eastus.azurecontainer.io:8000/detections');
  String? userId = Auth().currentUser?.uid;

  var now = DateTime.now();
  String detectionDate = DateFormat('yyyy-MM-dd').format(now);

  Map<String, dynamic> request = {
    'user_id': userId,
    'detection_date': detectionDate,
    'currency_id': currencyId,
    'classification': classification,
    'percentage': percentage,
    'image_url': imageUrl
  };


  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(request)
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Failed to save detection via API');
  }
}

Future<List<Map<String, dynamic>>> listDetectionsByUser() async {
  String? userId = Auth().currentUser?.uid;
  //print(userId);
  var url = Uri.parse('http://safycash-api.aadac9d6h9ccgtdz.eastus.azurecontainer.io:8000/detections/user/$userId');
  print("Si llego hasta el service y se hará la petición");
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  //print("Ya está la respuesta");
  if (response.statusCode == 200) {
    //print("La respuesta fue poritiva");
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Map<String, dynamic>> result = jsonResponse.map((data) {
      return Map<String, dynamic>.from(data);
    }).toList();
    return result;
  } else {
    throw Exception('Failed to load detections by user via API');
  }

}

Future<String> deleteDetection(
  int detectionId,
  String imageUrl,
  ) async {

  String? userId = Auth().currentUser?.uid;
  var url = Uri.parse('http://safycash-api.aadac9d6h9ccgtdz.eastus.azurecontainer.io:8000/detections/user/$userId/$detectionId');

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);

    await StoreData().deleteImageFromUrl(imageUrl);

    return jsonResponse;
  } else {
    throw Exception('Failed to save detection via API');
  }
}