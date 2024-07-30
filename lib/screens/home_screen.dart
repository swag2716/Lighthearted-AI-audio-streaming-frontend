import 'package:flutter/material.dart';
import '../widgets/audio_upload_widget.dart';
import '../services/api_service.dart';
import 'pdf_viewer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Streaming'),
      ),
      body: Column(
        children: [
          AudioUploadWidget(onAudioUploaded: _handleAudioUpload),
          // AudioPlayerWidget(),
        ],
      ),
    );
  }

  void _handleAudioUpload(String filePath) async {
    try {
      String pdfUrl = await _apiService.uploadAudioAndCreatePdf(filePath);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
