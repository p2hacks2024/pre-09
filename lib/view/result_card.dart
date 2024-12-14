import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
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
  // final List<ResultCard> resultCards = [
  //   ResultCard(question: "あ", answer: "a"),
  //   ResultCard(question: "い", answer: "i"),
  //   ResultCard(question: "う", answer: "u"),
  //   ResultCard(question: "え", answer: "e"),
  //   ResultCard(question: "お", answer: "o"),
  // ];

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
        debugPrint('カード終わったよ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);
    final quizResults = ref.watch(quizResultProvider);

    if (resultCards.isEmpty && quiz.isNotEmpty) {
      debugPrint('if文とっぱ');
      for (var i = 0; i < quiz.length; i++) {
        if (quizResults[i] == false) {
          debugPrint('2こ目のif文突破');
          resultCards.add(ResultCard(
            question: quiz[i],
            answer: QuizData.ebiQuizData[quiz[i]].toString(),
          ));
          debugPrint(resultCards.last.answer);
        }
      }
    }

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          _controller.value -= details.primaryDelta! / context.size!.height;
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
                  child: _buildCard(),
                );
              } else {
                return Text('カードなくなったよ');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
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
