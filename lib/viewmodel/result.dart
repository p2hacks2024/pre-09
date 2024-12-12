import 'package:flutter/material.dart';

class ResultPage1 extends StatelessWidget {
  const ResultPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('結果'),
      ),
      body: Center(
        child: const Text(
          'お疲れさまでした！',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
