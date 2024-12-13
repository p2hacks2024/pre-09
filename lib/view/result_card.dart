import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultFlashCard extends ConsumerStatefulWidget {
  const ResultFlashCard({super.key});

  @override
  ConsumerState<ResultFlashCard> createState() => _ResultFlashCardState();
}

class _ResultFlashCardState extends ConsumerState<ResultFlashCard>
    with SingleTickerProviderStateMixin {
  final List<ResultCard> resultCards = [];
  // final List<ResultCard> resultCards = [
  //   ResultCard(
  //       question: "あ",
  //       answer: "a"),
  //   ResultCard(
  //       question: "い",
  //       answer: "i"),
  //   ResultCard(
  //       question: "う",
  //       answer: "u"),
  //   ResultCard(
  //       question: "え",
  //       answer: "e"),
  //   ResultCard(
  //       question: "お",
  //       answer: "o"),
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
    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -2))
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
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final quiz = ref.read(quizProvider);
    final quizResults = ref.watch(quizResultProvider);

    if (resultCards.isEmpty && quiz.isNotEmpty) {
      for (var i = 0; i < quiz.length; i++) {
        if (quizResults[i] == false) {
          resultCards.add(ResultCard(
            question: quiz[i],
            answer: QuizData.ebiQuizData[quiz[i]].toString(),
          ));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: isExistCards
            ? AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      _controller.forward().then((_) {
                        _controller.reset();
                        _nextCard();
                      });
                    },
                    child: SlideTransition(
                      position: _animation,
                      child: _buildCard(),
                    ),
                  );
                },
              )
            : const Text('カードなくなったよ'),
      ),
    );
  }

  Widget _buildCard() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth / 1.5,
      height: deviceHeight / 1.5,
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
              style: TextStyle(
                  color: Colors.black,
                  fontSize: deviceWidth / 10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              resultCards[currentIndex].answer,
              style: TextStyle(color: Colors.red, fontSize: deviceWidth / 20),
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
