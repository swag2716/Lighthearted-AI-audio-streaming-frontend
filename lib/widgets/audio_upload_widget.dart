import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AudioUploadWidget extends StatelessWidget {
  final Function(String) onAudioUploaded;

  AudioUploadWidget({required this.onAudioUploaded});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Upload Audio file'),
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.audio,
          );
          if (result != null) {
            String filePath = result.files.single.path!;
            onAudioUploaded(filePath);
          }
        });
  }
}
