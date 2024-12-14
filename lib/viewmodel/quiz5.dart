// quiz1.dart
import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:gif/gif.dart';

class Quiz5 extends ConsumerStatefulWidget {
  const Quiz5({super.key});

  @override
  ConsumerState<Quiz5> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz5> with TickerProviderStateMixin {
  final _controller = TextEditingController();
  final _feedback = ValueNotifier<String>('');
  bool _isCorrect = false;
  bool isTextEnabled = true;

  late GifController _gifController;
  bool _isGifInitialized = false;

  @override
  void initState() {
    super.initState();

    // GifControllerを初期化
    _gifController = GifController(vsync: this);
    _isGifInitialized = true;
    _gifController.addListener(() {
      if (_gifController.value == 1) {
        _goToNextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  void _checkAnswer(String currentQuestion) {
    final correctAnswer = QuizData.ebiQuizData[currentQuestion];
    setState(() {
      isTextEnabled = false;
    });
    if (_controller.text.trim().toLowerCase() == correctAnswer?.toLowerCase()) {
      _feedback.value = '正解！';
      _isCorrect = true;
      ref.read(quizResultProvider.notifier).update((state) => [...state, true]);
    } else {
      _feedback.value = '不正解。正しい答えは: $correctAnswer';
      _isCorrect = false;
      ref
          .read(quizResultProvider.notifier)
          .update((state) => [...state, false]);
    }

    if (_isGifInitialized) {
      print("Playing GIF 5");
      _gifController
        ..reset()
        ..forward(); // GIFの再生
    }
  }

  void _goToNextQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    final totalQuestions = ref.read(quizProvider).length;
    final quizResults = ref.watch(quizResultProvider);

    // 次の問題へ進む
    if (currentIndex + 1 < totalQuestions) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
    } else {
      // もし最後の問題に到達した場合は次の画面へ
      final isCheckAllFalse =
          quizResults.isNotEmpty && quizResults.every((result) => !result);

      //router.go('/result', extra: isCheckAllFalse); // 例えばクイズ終了画面に遷移
      router.go(
          '/result_flash_card'); //TODO if文で全部間違えてたらこっち(ref.watch(quizResultProvider))
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = ref.watch(currentQuestionProvider);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight / 5),
          child: const EbidenceAppbar()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '次の単語を英語に翻訳してください:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              enabled: isTextEnabled,
              onSubmitted: (_) => _checkAnswer(currentQuestion),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '答えを入力',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _checkAnswer(currentQuestion),
              child: const Text('答えをチェック'),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<String>(
              valueListenable: _feedback,
              builder: (context, feedback, child) {
                return Text(
                  feedback,
                  style: TextStyle(
                    fontSize: 18,
                    color: _isCorrect ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(height: 16),
            if (_isGifInitialized)
              Gif(
                controller: _gifController,
                image: const AssetImage('assets/images/evi_allmiss.gif'),
                width: 150,
                height: 100,
                fit: BoxFit.contain,
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
