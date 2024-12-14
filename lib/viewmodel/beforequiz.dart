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
                // モードを保存
                ref.read(modeProvider.notifier).state = 'ebimode';

                // 全ての問題リストを取得
                final allEbiQuestions = QuizData.ebiQuizData.keys.toList();

                // 5つのランダムな問題を生成してリバーポッドに保存
                ref
                    .read(quizProvider.notifier)
                    .generateRandomQuestions(allEbiQuestions, 5);

                // ランダムに選ばれた問題をデバッグプリント
                final selectedQuestions = ref.read(quizProvider);
                print("ランダムに選ばれた問題: $selectedQuestions");

                // 次の画面に遷移
                router.go('/quiz1');
              },
              child: const Text('ebimode'),
            ),
            ElevatedButton(
              onPressed: () {
                // モードを保存
                ref.read(modeProvider.notifier).state = 'level1mode';

                // 全ての問題リストを取得
                final allL1Questions = QuizData.l1QuizData.keys.toList();

                // 5つのランダムな問題を生成してリバーポッドに保存
                ref
                    .read(quizProvider.notifier)
                    .generateRandomQuestions(allL1Questions, 5);

                // ランダムに選ばれた問題をデバッグプリント
                final selectedQuestions = ref.read(quizProvider);
                print("ランダムに選ばれた問題: $selectedQuestions");

                // 次の画面に遷移
                router.go('/quiz1');
              },
              child: const Text('LEVEL1mode'),
            ),
          ],
        ),
      ),
    );
  }
}
