import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:video_player/video_player.dart';

class Quiz4 extends ConsumerStatefulWidget {
  const Quiz4({super.key});

  @override
  ConsumerState<Quiz4> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz4> {
  final _controller = TextEditingController();
  final _feedback = ValueNotifier<String>('');
  bool _isCorrect = false;

  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // 動画プレーヤーの初期化
    _videoPlayerController = VideoPlayerController.asset(
      'assets/movies/ebi.mp4',
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        _goToNextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _checkAnswer(String currentQuestion) {
    final correctAnswer = QuizData.ebiQuizData[currentQuestion];
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

    if (_isVideoInitialized) {
      _videoPlayerController
        ..seekTo(Duration.zero)
        ..play();
    }
  }

  void _goToNextQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    final totalQuestions = ref.read(quizProvider).length;

    // 次の問題へ進む
    if (currentIndex + 1 < totalQuestions) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
      router.go('/quiz5');
    } else {
      // もし最後の問題に到達した場合は次の画面へ
      router.go('/quizComplete'); // 例えばクイズ終了画面に遷移
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
            if (_isVideoInitialized)
              Container(
                width: 200,
                height: 150,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
