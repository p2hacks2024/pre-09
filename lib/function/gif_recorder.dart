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
  ScreenRecorderController controller = ScreenRecorderController();
  bool get canExport => controller.exporter.hasFrames;
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
                // GIFを録画するためのImage.assetで画像を表示
                ScreenRecorder(
                  height: 500,
                  width: 500,
                  controller: controller,
                  child: GestureDetector(
                    onTap: () {
                      // 画像のタップやアニメーションの変更を検出する場合はここに処理を追加
                    },
                    child: Image.asset(
                      'assets/images/2d00f709f9ffc6434801ec32fa056089.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (!_recording && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.start();
                        setState(() {
                          _recording = true;
                        });
                      },
                      child: const Text('Start Recording'),
                    ),
                  ),
                if (_recording && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.stop();
                        setState(() {
                          _recording = false;
                        });
                      },
                      child: const Text('Stop Recording'),
                    ),
                  ),
                if (canExport && !_exporting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _exporting = true;
                        });
                        var frames = await controller.exporter.exportFrames();
                        if (frames == null) {
                          throw Exception();
                        }
                        setState(() => _exporting = false);
                        showDialog(
                          context: context as dynamic,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 500,
                                width: 500,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: frames.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final image = frames[index].image;
                                    return SizedBox(
                                      height: 150,
                                      child: Image.memory(
                                        image.buffer.asUint8List(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Export as frames'),
                    ),
                  ),
                if (canExport && !_exporting) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _exporting = true;
                        });
                        var gif = await controller.exporter.exportGif();
                        if (gif == null) {
                          throw Exception();
                        }
                        setState(() => _exporting = false);
                        showDialog(
                          context: context as dynamic,
                          builder: (context) {
                            return AlertDialog(
                              content: Image.memory(Uint8List.fromList(gif)),
                            );
                          },
                        );
                      },
                      child: const Text('Export as GIF'),
                    ),
                  ),
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
                  )
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }
}
