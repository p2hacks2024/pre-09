import 'package:ebidence/constant/app_color.dart';
import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/view/result_card.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:gif/gif.dart';

class Quiz3 extends ConsumerStatefulWidget {
  const Quiz3({super.key});

  @override
  ConsumerState<Quiz3> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz3> with TickerProviderStateMixin {
  final _controller = TextEditingController();
  final _feedback = ValueNotifier<String>('');
  bool isTextEnabled = true;
  bool _isButtonPressed = false; // Track if button is pressed
  List<ResultCard> resultCards = [];

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
      _isButtonPressed = true;
    });
    if (_controller.text.trim().toLowerCase() == correctAnswer?.toLowerCase()) {
      _feedback.value = '正解！';
      ref.read(quizResultProvider.notifier).update((state) => [...state, true]);
      debugPrint('正解');
    } else {
      _feedback.value = '不正解。正しい答えは: $correctAnswer';
      ref
          .read(quizResultProvider.notifier)
          .update((state) => [...state, false]);

      //間違えた問題をriverpodのListに入れる
      resultCards.add(ResultCard(
        question: currentQuestion,
        answer: correctAnswer.toString(),
      ));
      debugPrint('不正解');
      debugPrint('aiueo::${resultCards.length.toString()}');
      debugPrint('aiueo::${resultCards.last.question}');
    }

    if (_isGifInitialized) {
      print("Playing GIF 3");
      _gifController
        ..reset()
        ..forward(); // GIFの再生
    }
  }

  void _l1CheckAnswer(String currentQuestion) {
    setState(() {
      isTextEnabled = false;
      _isButtonPressed = true;
    });
    final correctAnswer = QuizData.l1QuizData[currentQuestion];
    if (_controller.text.trim().toLowerCase() == correctAnswer?.toLowerCase()) {
      _feedback.value = '正解！';
      ref.read(quizResultProvider.notifier).update((state) => [...state, true]);
    } else {
      _feedback.value = '不正解。正しい答えは: $correctAnswer';
      ref
          .read(quizResultProvider.notifier)
          .update((state) => [...state, false]);

      //間違えた問題をriverpodのListに入れる
      resultCards.add(ResultCard(
        question: currentQuestion,
        answer: correctAnswer.toString(),
      ));
    }

    if (_isGifInitialized) {
      print("Playing GIF 3");
      _gifController
        ..reset()
        ..forward(); // GIFの再生
    }
  }

  void _goToNextQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    final totalQuestions = ref.read(quizProvider).length;

    // 次の問題へ進む
    if (currentIndex + 1 < totalQuestions) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
      router.go('/quiz4');
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
                    '3 / 5',
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
                      controller: _controller,
                      autofocus: true,
                      enabled: isTextEnabled,
                      onSubmitted: (_) => _checkAnswer(currentQuestion),
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
