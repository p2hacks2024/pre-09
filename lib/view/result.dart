import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String imageId;

  ResultPage({super.key, required this.imageId});

  Future<Uint8List> _downloadImage() async {
    try {
      log("1");
      final doc = await FirebaseFirestore.instance
          .collection("images")
          .doc(imageId)
          .get();
      log("2");
      final String imageUrl = doc.data()!['url']; // 'url'フィールド名を確認
      log("3");
      final httpsReference = FirebaseStorage.instance.refFromURL(imageUrl);
      log("4");
      const oneMegabyte = 1024 * 1024;
      log("5");
      final Uint8List? data = await httpsReference.getData(oneMegabyte);
      log("6");
      return data!;
    } catch (e) {
      log(e.toString());
      throw Exception('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('画像表示'),
      ),
      body: FutureBuilder(
        future: _downloadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('エラーが発生しました'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('画像が見つかりません'));
          }

          return Center(
            child: Image.memory(
              snapshot.data!,
            ),
          );
        },
      ),
    );
  }
}
