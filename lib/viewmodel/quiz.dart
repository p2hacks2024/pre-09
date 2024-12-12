import 'dart:math';

import 'package:ebidence/constant/quiz_data.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _controller = TextEditingController();
  final _random = Random();
  String _currentQuestion = '';
  String _feedback = '';
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
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
    });
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
              onPressed: () {
                _checkAnswer();
              },
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _generateNewQuestion();
              },
              child: const Text('次の問題へ'),
            ),
          ],
        ),
      ),
    );
  }
}
