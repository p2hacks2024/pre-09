import 'package:ebidence/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPage1 extends ConsumerWidget {
  const ResultPage1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizResults = ref.watch(quizResultProvider);
    debugPrint('クイズ結果: $quizResults');
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
