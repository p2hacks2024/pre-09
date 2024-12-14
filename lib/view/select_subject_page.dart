import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';

import 'package:flutter/material.dart';

import 'package:ebidence/constant/app_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectSubjectPage extends ConsumerStatefulWidget {
  const SelectSubjectPage({super.key});

  @override
  ConsumerState<SelectSubjectPage> createState() => _SelectSubjectPageState();
}

class _SelectSubjectPageState extends ConsumerState<SelectSubjectPage> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final buttonStyle2 = IconButton.styleFrom(
      foregroundColor: AppColor.brand.primary,
      backgroundColor: AppColor.brand.secondary,
      iconSize: deviceWidth / 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceHeight / 5),
        child: const EbidenceAppbar(),
      ),
      backgroundColor: AppColor.brand.primary,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0.9, 1),
            child: Image.asset(
              'images/evi_cam.png',
              width: 325,
              height: 325,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Align(
                              alignment: const Alignment(0.9, 1),
                              child: Image.asset(
                                'images/evi_cam.png',
                                width: 325,
                                height: 325,
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                'images/hukidashi_big.png',
                                width: 900,
                                height: 700,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0.3, 100),
                              child: Column(
                                children: [],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 200),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      minimumSize: Size(
                                          deviceWidth / 2.5, deviceHeight / 8),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      // モードを保存
                                      ref.read(modeProvider.notifier).state =
                                          'level1mode';

                                      // 全ての問題リストを取得
                                      final allEbiQuestions =
                                          QuizData.l1QuizData.keys.toList();

                                      // 5つのランダムな問題を生成してリバーポッドに保存
                                      ref
                                          .read(quizProvider.notifier)
                                          .generateRandomQuestions(
                                              allEbiQuestions, 5);

                                      // ランダムに選ばれた問題をデバッグプリント
                                      final selectedQuestions =
                                          ref.read(quizProvider);
                                      print("ランダムに選ばれた問題: $selectedQuestions");
                                      router.go('/quiz1');
                                    },
                                    child: const Text(
                                      'LEVEL 1',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      minimumSize: Size(
                                          deviceWidth / 2.5, deviceHeight / 8),
                                      backgroundColor: Colors.grey[600],
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'LEVEL 2',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      minimumSize: Size(
                                          deviceWidth / 2.5, deviceHeight / 8),
                                      backgroundColor: Colors.grey[600],
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'LEVEL 3',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0.45, -0.83),
                              child: IconButton(
                                style: buttonStyle2,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("英語", style: TextStyle(fontSize: 70)),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog();
                      },
                    );
                  },
                  child: const Text("漢字", style: TextStyle(fontSize: 70)),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog();
                      },
                    );
                  },
                  child: const Text("ドイツ語", style: TextStyle(fontSize: 70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
