import 'package:ebidence/provider/quiz_provider.dart';
import 'package:ebidence/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ebidence/constant/quiz_data.dart';

class Beforequiz extends ConsumerWidget {
  const Beforequiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AIUEO',
              style: TextStyle(fontSize: 24, fontFamily: 'Inter'),
            ),
            const Text(
              'クイズへ続く',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                // 全ての問題リストを取得
                final allQuestions = QuizData.ebiQuizData.keys.toList();

                // 5つのランダムな問題を生成してリバーポッドに保存
                ref
                    .read(quizProvider.notifier)
                    .generateRandomQuestions(allQuestions, 5);

                // 状態から選ばれた問題を取得してデバッグコンソールに出力
                final selectedQuestions = ref.read(quizProvider);
                debugPrint('選ばれた問題: $selectedQuestions');

                // 次の画面に遷移
                router.go('/quiz1');
              },
              child: const Text('次へ'),
            )
          ],
        ),
      ),
    );
  }
}
