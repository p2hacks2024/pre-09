import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendFirebase extends StatefulWidget {
  const SendFirebase({super.key});

  @override
  State<SendFirebase> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<SendFirebase> {
  final storageRef = FirebaseStorage.instance.ref();
  late final Reference cornRef;

  @override
  void initState() {
    super.initState();
    cornRef = storageRef.child("2d00f709f9ffc6434801ec32fa056089.jpg");
  }

  Future<Uint8List> getImageDataFromAssets(String path) async {
    // assets から画像データを Uint8List として読み込む
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<void> uploadImageAndSaveToFirestore() async {
    try {
      // 画像データを取得
      Uint8List data = await getImageDataFromAssets(
          'assets/images/2d00f709f9ffc6434801ec32fa056089.jpg');

      // Firebase Storage にアップロード
      await cornRef.putData(data);

      // アップロードされた画像のダウンロードURLを取得
      final String downloadUrl = await cornRef.getDownloadURL();

      // Firestore に保存
      await FirebaseFirestore.instance
          .collection('images')
          .add({'url': downloadUrl});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像とURLの保存に成功しました！')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: ${e.message}')),
      );
    }
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
              onPressed: uploadImageAndSaveToFirestore,
              child: const Text('アップロードしてFirestoreに保存'),
            ),
          ],
        ),
      ),
    );
  }
}
