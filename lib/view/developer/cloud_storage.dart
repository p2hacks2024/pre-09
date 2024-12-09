import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CloudStorage extends StatefulWidget {
  const CloudStorage({super.key});

  @override
  State<CloudStorage> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<CloudStorage> {
  final storageRef = FirebaseStorage.instance.ref();
  late final Reference cornRef;

  @override
  void initState() {
    super.initState();
    cornRef = storageRef.child("2d00f709f9ffc6434801ec32fa056089.jpg");
  }

  Future<Uint8List> getImageDataFromAssets(String path) async {
    // 画像データを assets からバイトとして読み込む
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/2d00f709f9ffc6434801ec32fa056089.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                try {
                  // 画像データを Uint8List として取得
                  Uint8List data = await getImageDataFromAssets(
                      'assets/images/2d00f709f9ffc6434801ec32fa056089.jpg');
                  // Firebase Storage にデータをアップロード
                  await cornRef.putData(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('画像のアップロードに成功しました！')),
                  );
                } on FirebaseException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('エラー: ${e.message}')),
                  );
                }
              },
              child: const Text('Storage にアップロード'),
            ),
          ],
        ),
      ),
    );
  }
}
