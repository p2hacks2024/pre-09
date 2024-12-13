// quiz_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizProvider = StateNotifierProvider<QuizNotifier, List<String>>((ref) {
  return QuizNotifier();
});

class QuizNotifier extends StateNotifier<List<String>> {
  QuizNotifier() : super([]);

  void generateRandomQuestions(List<String> allQuestions, int count) {
    state = (allQuestions..shuffle()).take(count).toList();
  }
}

final currentQuestionIndexProvider =
    StateProvider<int>((ref) => 0); // 現在の問題のインデックスを管理

final currentQuestionProvider = Provider<String>((ref) {
  final index = ref.watch(currentQuestionIndexProvider);
  final selectedQuestions = ref.watch(quizProvider);
  return selectedQuestions.isNotEmpty ? selectedQuestions[index] : '';
});
