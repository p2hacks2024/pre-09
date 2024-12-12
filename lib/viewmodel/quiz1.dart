import 'package:ebidence/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/routes.dart';
import 'package:video_player/video_player.dart';

class Quiz1 extends ConsumerStatefulWidget {
  const Quiz1({super.key});

  @override
  ConsumerState<Quiz1> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz1> {
  final _controller = TextEditingController();
  String _feedback = '';
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
        //debugPrint()
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _checkAnswer(String question) {
    final correctAnswer = QuizData.ebiQuizData[question];
    setState(() {
      if (_controller.text.trim().toLowerCase() ==
          correctAnswer?.toLowerCase()) {
        _feedback = '正解！';
        _isCorrect = true;
      } else {
        _feedback = '不正解。正しい答えは: $correctAnswer';
        _isCorrect = false;
      }

      if (_isVideoInitialized) {
        _videoPlayerController
          ..seekTo(Duration.zero)
          ..play();
      }
    });
  }

  void _goToNextQuestion() {
    final currentIndex = ref.read(currentQuizIndexProvider);
    if (currentIndex < 4) {
      // 次の問題を取得
      final nextIndex = currentIndex + 1;
      final questions = ref.read(quizProvider);
      final nextQuestion = questions[nextIndex];

      // 次の問題をデバッグコンソールに出力
      debugPrint('次の問題: $nextQuestion');

      // インデックスを更新し、次の画面に遷移
      ref.read(currentQuizIndexProvider.notifier).state++;
      router.go('/quiz${nextIndex + 1}');
    } else {
      router.go('/result'); // 全てのクイズ終了後
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(quizProvider);
    final currentIndex = ref.watch(currentQuizIndexProvider);
    final currentQuestion = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('日本語 -> 英語クイズ'),
      ),
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
            Text(
              _feedback,
              style: TextStyle(
                fontSize: 18,
                color: _isCorrect ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_isVideoInitialized)
              SizedBox(
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
