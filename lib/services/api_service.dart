import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String baseUrl =
      'http://ec2-13-201-139-194.ap-south-1.compute.amazonaws.com:5000';

  Future<String> uploadAudioAndCreatePdf(String filePath) async {
    var uri = Uri.parse('$baseUrl/process_audio');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'audio',
        filePath,
        contentType: MediaType('audio', 'mpeg'),
      ));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);
      return jsonData['pdf_url'];
    } else {
      throw Exception('Failed to upload audio and create PDF');
    }
  }
}
