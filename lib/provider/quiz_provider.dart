import 'dart:math';

import 'package:ebidence/constant/quiz_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizProvider = Provider<List<String>>((ref) {
  final random = Random();
  final keys = QuizData.ebiQuizData.keys.toList();

  // ランダムに5問選択
  final selectedQuestions = <String>{};
  while (selectedQuestions.length < 5) {
    selectedQuestions.add(keys[random.nextInt(keys.length)]);
  }

  return selectedQuestions.toList();
});

final currentQuizIndexProvider = StateProvider<int>((ref) => 0);
