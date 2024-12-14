import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebidence/routes.dart';
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
            child: Column(
              children: [
                Image.memory(
                  snapshot.data!,
                ),
                _buildCustomButton(
                  label: 'はじめる',
                  onPressed: () {
                    router.go('/beforequiz');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildCustomButton({
  required String label,
  required VoidCallback? onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1, // 影の広がり
          blurRadius: 4, // ぼかし具合
          offset: const Offset(0, 4), // 影の位置（x, y）
        ),
      ],
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFA15E), // ボタンの背景色
        foregroundColor: Colors.white, // テキストの色
        minimumSize: const Size(200, 60), // ボタンのサイズ（幅と高さ）
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // 丸みの半径
        ),
        shadowColor: Colors.transparent, // ElevatedButton自身の影を無効化
        elevation: 0, // ElevatedButton標準影をオフ
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24, // テキストのサイズ
          fontWeight: FontWeight.bold, // テキストの太さ
        ),
      ),
    ),
  );
}
