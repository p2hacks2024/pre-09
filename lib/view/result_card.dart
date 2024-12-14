import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:ebidence/viewmodel/postimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultFlashCard extends ConsumerStatefulWidget {
  //final bool isCheakAllFalse;
  const ResultFlashCard({super.key});

  @override
  ConsumerState<ResultFlashCard> createState() => _ResultFlashCard();
}

class _ResultFlashCard extends ConsumerState<ResultFlashCard>
    with SingleTickerProviderStateMixin {
  List<ResultCard> resultCards = [];

  late int currentIndex;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late bool isExistCards;

  @override
  void initState() {
    super.initState();
    isExistCards = true;
    currentIndex = 0;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -2.5))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextCard() {
    setState(() {
      if (currentIndex < resultCards.length - 1) {
        currentIndex++;
      } else {
        isExistCards = false;
        ref.read(resultCardListProveder.notifier).state = resultCards;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);
    final quizResults = ref.watch(quizResultProvider);
    final quizMode = ref.watch(modeProvider);

    if (resultCards.isEmpty && quiz.isNotEmpty && quizMode == 'ebimode') {
      for (var i = 0; i < quiz.length; i++) {
        if (quizResults[i] == false) {
          resultCards.add(ResultCard(
            question: quiz[i],
            answer: QuizData.ebiQuizData[quiz[i]].toString(),
          ));
          debugPrint(resultCards.last.answer);
        }
      }
    }

    if (resultCards.isEmpty && quiz.isNotEmpty && quizMode == 'level1mode') {
      for (var i = 0; i < quiz.length; i++) {
        if (quizResults[i] == false) {
          resultCards.add(ResultCard(
            question: quiz[i],
            answer: QuizData.l1QuizData[quiz[i]].toString(),
          ));
          debugPrint(resultCards.last.answer);
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          //全問不正解用の画像作成処理↓
          if (resultCards.length == 5) PostImage(),
          //最終結果画面の処理↓

          //全問不正解用の吹き出しの処理↓
          _finalResultScreen(),
          //FlashCardの処理↓
          if (isExistCards)
            GestureDetector(
              onVerticalDragUpdate: (details) {
                _controller.value -=
                    details.primaryDelta! / context.size!.height;
              },
              onVerticalDragEnd: (details) {
                if (_controller.value > -0.5) {
                  _controller.forward().then((_) {
                    _controller.reset();
                    _nextCard();
                  });
                }
              },
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    if (isExistCards) {
                      return SlideTransition(
                        position: _animation,
                        child: _buildFlashCard(),
                      );
                    } else {
                      return const Text('カードなくなったよ');
                    }
                  },
                ),
              ),
            ),
          //PostImage(),
        ],
      ),
    );
  }

  Widget _finalResultScreen() {
    return Center(
      child: Column(
        children: [
          Text('aiueo'),
        ],
      ),
    );
  }

//FlashCardの処理
  Widget _buildFlashCard() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultCards[currentIndex].question,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              resultCards[currentIndex].answer,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard {
  final String question;
  final String answer;

  ResultCard({required this.question, required this.answer});
}
