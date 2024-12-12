import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String imageId;

  const ResultPage({super.key, required this.imageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('結果画面'),
          Text(imageId),
        ],
      ),
    );
  }
}
