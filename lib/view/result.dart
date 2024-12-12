import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultPage extends StatelessWidget {
  final String imageId;

  const ResultPage({super.key, required this.imageId});

  Future<String> _fetchImageUrl(String docId) async {
    final docRef = FirebaseFirestore.instance.collection('images').doc(docId);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data();
      if (data != null && data['url'] != null) {
        return data['url']; // Firestore のフィールド名が 'url' の場合
      }
    }
    throw Exception('Image URL not found');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('結果画面'),
      ),
      body: FutureBuilder<String>(
        future: _fetchImageUrl(imageId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('画像が見つかりません'));
          } else {
            final imageUrl = snapshot.data!;
            return Column(
              children: [
                const Text('結果画面'),
                Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('画像の読み込みに失敗しました');
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
