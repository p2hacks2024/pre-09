import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screen_recorder/screen_recorder.dart';

class GifRecorder extends StatefulWidget {
  const GifRecorder({super.key});

  @override
  State<GifRecorder> createState() => _GifRecorderState();
}

class _GifRecorderState extends State<GifRecorder> {
  bool _recording = false;
  bool _exporting = false;
  final ScreenRecorderController controller = ScreenRecorderController();
  bool get canExport => controller.exporter.hasFrames;

  // GIFの再生時間（秒単位）
  final int gifDuration = 2;

  Future<void> _exportGif() async {
    setState(() {
      _exporting = true;
    });

    // GIFをエクスポート
    final gif = await controller.exporter.exportGif();
    if (gif == null) {
      throw Exception("Failed to export GIF");
    }

    setState(() {
      _exporting = false;
    });

    // エクスポートしたGIFをダイアログで表示
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Exported GIF"),
          content: Image.memory(Uint8List.fromList(gif)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _startRecording() {
    controller.start();
    setState(() {
      _recording = true;
    });

    // GIF再生時間後に録画停止してGIFをエクスポート
    Future.delayed(Duration(seconds: gifDuration), () async {
      if (_recording) {
        controller.stop();
        setState(() {
          _recording = false;
        });
        await _exportGif(); // 録画停止後にGIFをエクスポート
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gif Recorder'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_exporting)
                const Center(child: CircularProgressIndicator())
              else ...[
                ScreenRecorder(
                  height: 500,
                  width: 500,
                  controller: controller,
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.blue,
                          height: 600,
                          width: 500,
                        ),
                        Image.asset(
                          'assets/images/tumblr_inline_pk03u2iESS1qa5y5a_500.gif',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                if (!_recording && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _startRecording,
                      child: const Text('Start Recording'),
                    ),
                  ),
                if (_recording && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.stop();
                        setState(() {
                          _recording = false;
                        });
                        await _exportGif(); // 手動停止時もGIFをエクスポート
                      },
                      child: const Text('Stop Recording'),
                    ),
                  ),
                if (canExport && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.exporter.clear();
                        });
                      },
                      child: const Text('Clear recorded data'),
                    ),
                  ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
