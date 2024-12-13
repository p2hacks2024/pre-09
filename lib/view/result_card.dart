import 'package:ebidence/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultCardScreen extends ConsumerStatefulWidget {
  const ResultCardScreen({super.key});

  @override
  ConsumerState<ResultCardScreen> createState() => _ResultCardScreenState();
}

class _ResultCardScreenState extends ConsumerState<ResultCardScreen>
    with SingleTickerProviderStateMixin {
  final List<ResultCard> resultCards = [
    ResultCard(
        question: "コーヒーショップの場所",
        answer: "Where is the coffee shop after exiting the station?"),
    ResultCard(
        question: "レストランの予約",
        answer: "I'd like to make a reservation for dinner."),
    ResultCard(
        question: "電車の乗り方",
        answer: "How do I take the train to the city center?"),
    ResultCard(
        question: "観光スポットの推薦",
        answer: "Can you recommend some popular tourist attractions?"),
    ResultCard(
        question: "ホテルのチェックイン時間",
        answer: "What time is check-in at the hotel?"),
  ];

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
    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.5))
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
    final resultCard = ref.read(quizProvider);
    final quizResults = ref.watch(quizResultProvider);

    debugPrint(resultCard[0]);

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
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultCards[currentIndex].question,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              resultCards[currentIndex].answer,
              style: const TextStyle(color: Colors.white, fontSize: 16),
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
