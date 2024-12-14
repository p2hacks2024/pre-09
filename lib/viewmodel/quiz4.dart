// quiz1.dart
import 'package:ebidence/constant/app_color.dart';
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
  bool _isButtonPressed = false; // Track if button is pressed

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

  void _l1CheckAnswer(String currentQuestion) {
    final correctAnswer = QuizData.l1QuizData[currentQuestion];
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
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '英語　LEVEL1',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '4 / 5',
                    style: TextStyle(fontSize: 25, color: AppColor.text.gray),
                  ),
                  Text(
                    currentQuestion,
                    style: const TextStyle(
                        fontSize: 150, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // 背景色
                      borderRadius: BorderRadius.circular(10), // 角丸
                    ),
                    child: TextField(
                      cursorColor: AppColor.brand.secondary,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '回答を入力',
                        hintStyle:
                            TextStyle(color: AppColor.text.gray, fontSize: 30),
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColor.text.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1, // 影の広がり
                          blurRadius: 4, // ぼかし具合
                          offset: const Offset(0, 4), // 影の位置（x, y）
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.brand.logo, // ボタンの背景色
                        foregroundColor: Colors.white, // テキストの色
                        minimumSize: const Size(200, 60), // ボタンのサイズ（幅と高さ）
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // 丸みの半径
                        ),
                        shadowColor:
                            Colors.transparent, // ElevatedButton自身の影を無効化
                        elevation: 0, // ElevatedButtonの標準影をオフ
                      ),
                      onPressed: _isButtonPressed
                          ? null // Disable button if already pressed
                          : () {
                              setState(() {
                                _isButtonPressed =
                                    true; // Disable button on press
                              });
                              final mode = ref.read(modeProvider); // 現在のモードを取得
                              if (mode == 'ebimode') {
                                _checkAnswer(currentQuestion);
                              } else if (mode == 'level1mode') {
                                _l1CheckAnswer(currentQuestion);
                              }
                            },
                      child: const Text(
                        '回答',
                        style: TextStyle(
                          fontSize: 30, // テキストのサイズ
                          fontWeight: FontWeight.bold, // テキストの太さ
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (_isVideoInitialized)
              Align(
                alignment: Alignment(1, 1),
                child: Container(
                  width: 200,
                  height: 150,
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
