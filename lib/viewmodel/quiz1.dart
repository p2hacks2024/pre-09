import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/routes.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:video_player/video_player.dart';

class Quiz1 extends StatefulWidget {
  const Quiz1({super.key});

  @override
  State<Quiz1> createState() => _QuizState();
}

class _QuizState extends State<Quiz1> {
  final _controller = TextEditingController();
  final _random = Random();
  String _currentQuestion = '';
  String _feedback = '';
  bool _isCorrect = false;

  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();

    // 動画プレーヤーの初期化
    _videoPlayerController = VideoPlayerController.asset(
      'assets/movies/ebi.mp4', // 動画ファイルのパス
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });

    // 動画の再生が終了したかどうかをチェックするリスナーを追加
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        // 動画の再生が終わったら次の問題に進む
        _goToNextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _generateNewQuestion() {
    final keys = QuizData.ebiQuizData.keys.toList();
    setState(() {
      _currentQuestion = keys[_random.nextInt(keys.length)];
      _feedback = '';
      _controller.clear();
    });
  }

  void _checkAnswer() {
    final correctAnswer = QuizData.ebiQuizData[_currentQuestion];
    setState(() {
      if (_controller.text.trim().toLowerCase() ==
          correctAnswer?.toLowerCase()) {
        _feedback = '正解！';
        _isCorrect = true;
      } else {
        _feedback = '不正解。正しい答えは: $correctAnswer';
        _isCorrect = false;
      }

      // 動画の再生
      if (_isVideoInitialized) {
        _videoPlayerController
          ..seekTo(Duration.zero) // 動画を最初に戻す
          ..play();
      }
    });
  }

  // 動画終了後に次の問題へ遷移
  void _goToNextQuestion() {
    router.go('/quiz2'); // 次の問題へ遷移
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日本語 -> 英語クイズ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '次の単語を英語に翻訳してください:',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              _currentQuestion,
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
              onPressed: _checkAnswer,
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
              // 動画の表示
              Container(
                width: 200, // 幅を指定
                height: 150, // 高さを指定
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
