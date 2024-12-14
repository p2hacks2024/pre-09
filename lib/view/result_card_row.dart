import 'package:ebidence/constant/app_color.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/viewmodel/ebidence_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultCardRow extends ConsumerStatefulWidget {
  const ResultCardRow({super.key});

  @override
  ConsumerState<ResultCardRow> createState() => _ResultCardRowState();
}

class _ResultCardRowState extends ConsumerState<ResultCardRow> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final resultCardList = ref.watch(resultCardListProveder); //List<ResultCard>

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight / 5),
          child: const EbidenceAppbar()),
      body: Center(
        child: Column(
          children: [
            Text(
              '結果',
              style: TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox()),
                Center(
                  child: Text(
                    (5 - resultCardList.length).toString(),
                    style: TextStyle(
                      fontSize: 150,
                      fontFamily: 'NotoSansJP-Bold',
                      color: AppColor.text.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Text(
                        '問正解！',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'NotoSansJP-Bold',
                          color: AppColor.text.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      '間違えた問題',
                      style: TextStyle(fontSize: 30),
                    ),
                    if (resultCardList.isNotEmpty) ...[
                      Row(
                        children: [
                          for (int i = 0; i < resultCardList.length; i++) ...[
                            Container(
                              width: 110,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      resultCardList[i].question,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      resultCardList[i].answer,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (i < 4) SizedBox(width: 10),
                          ],
                        ],
                      ),
                    ] else
                      const Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'なし',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                  ],
                ),
                const SizedBox(
                  width: 150,
                ),
                Column(
                  children: [
                    Image.asset(
                      'images/evi_cam.png',
                      height: 238,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCustomButton(
                  label: 'つづける',
                  onPressed: () {
                    router.go('/beforequiz');
                    print('つづけるボタンが押されました');
                  },
                ),
                const SizedBox(width: 20), // ボタン間のスペース
                _buildCustomButton(
                  label: 'やめる',
                  onPressed: () {
                    router.go('/');
                    print('やめるボタンが押されました');
                  },
                ),
              ],
            ),
            Text(
              '@ガリバタコーン',
              style: TextStyle(fontSize: 12, color: AppColor.brand.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

// カスタムボタンの作成
Widget _buildCustomButton({
  required String label,
  required VoidCallback? onPressed,
}) {
  return Container(
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
        backgroundColor: const Color(0xFFFFA15E), // ボタンの背景色
        foregroundColor: Colors.white, // テキストの色
        minimumSize: const Size(200, 60), // ボタンのサイズ（幅と高さ）
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // 丸みの半径
        ),
        shadowColor: Colors.transparent, // ElevatedButton自身の影を無効化
        elevation: 0, // ElevatedButton標準影をオフ
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24, // テキストのサイズ
          fontWeight: FontWeight.bold, // テキストの太さ
        ),
      ),
    ),
  );
}
