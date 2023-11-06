import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> predictImage(String filePath) async {
  //var url = Uri.parse('https://safycash-api-je3ddljhia-rj.a.run.app/predictions/soles');
  var url = Uri.parse('http://safycash-api.aadac9d6h9ccgtdz.eastus.azurecontainer.io:8000/predictions/yolo/soles');

  // http://0.0.0.0:8000/predictions/soles
  // http://192.168.18.11:8000/predictions/yolo/soles
  

  var request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('file', filePath))
    ..headers['accept'] = 'application/json';

  var response = await request.send();
  var responseString = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(responseString);
    return jsonResponse;
  } else {
    throw Exception('Failed to predict image');
  }
}