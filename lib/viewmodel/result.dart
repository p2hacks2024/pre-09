import 'package:ebidence/provider/quiz_provider.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPage1 extends ConsumerWidget {
  final bool isCheakAllFalse;
  const ResultPage1(this.isCheakAllFalse, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizResults = ref.watch(quizResultProvider);
    final selectedQuestions = ref.read(quizProvider);

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    debugPrint('選ばれた問題: $selectedQuestions');
    debugPrint('クイズ結果: $quizResults');

    debugPrint('isCheakAllFalse: $isCheakAllFalse');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight / 5),
          child: const EbidenceAppbar()),
      body: Center(
        child: Stack(
          children: [
            const Text(
              'お疲れさまでした！',
              style: TextStyle(fontSize: 24),
            ),
            // if (isCheakAllFalse == true)
            //   Container(
            //     color: Colors.grey,
            //     width: 400,
            //     height: 400,
            //     child: Text('全部間違えたやろーー'),
            //   )
          ],
        ),
      ),
    );
  }
}
