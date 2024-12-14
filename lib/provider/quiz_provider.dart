// quiz_provider.dart
import 'package:ebidence/view/result_card.dart';
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

final quizResultProvider = StateProvider<List<bool>>((ref) => []);

// モードを保持するプロバイダー
final modeProvider = StateProvider<String>((ref) => '');

//間違えた問題のリストを保持
final resultCardListProvider = StateProvider<List<ResultCard>>((ref) => []);

//ロード中かどうかの判断
final isSaveImageProvider = StateProvider<bool>((ref) => false);
