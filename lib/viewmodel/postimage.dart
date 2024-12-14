import 'package:ebidence/constant/app_color.dart';
import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostImage extends ConsumerWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 1200,
              height: 630,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 8.0,
                          child: Material(
                            elevation: 2, // 影をつける高さ
                            shadowColor:
                                Colors.black.withOpacity(0.3), // 影の色と透明度
                            borderRadius: BorderRadius.circular(8), // 角丸をつける場合
                            child: Stack(
                              alignment: Alignment.center, // 中央に配置
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.brand.secondary,
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 4),
                                        blurRadius: 2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // 白色の背景
                                    borderRadius:
                                        BorderRadius.circular(100), // 角丸
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.1), // 影の色と透明度
                                        blurRadius: 4, // 影のぼかし半径
                                        offset: Offset(0, 4), // 下側に影を移動
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'images/ebidence_title.png',
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    '結果',
                    style: TextStyle(fontSize: 35),
                  ),
                  Text(
                    '全問不正解',
                    style: TextStyle(
                      fontSize: 120,
                      fontFamily: 'NotoSansJP-Bold',
                      color: AppColor.text.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '間違えた問題',
                            style: TextStyle(fontSize: 30),
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++) ...[
                                Container(
                                  width: 110,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black),
                                    color: AppColor.ui.shadow,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          quiz[i],
                                          //'あいうえお',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          QuizData.ebiQuizData[quiz[i]]
                                              .toString(),
                                          //'aiueo',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (i < 4) SizedBox(width: 10),
                              ],
                              // Container(
                              //   color: AppColor.ui.shadow,
                              //   width: 110,
                              //   height: 90,
                              // ),
                              // SizedBox(width: 10),
                              // Container(
                              //   color: AppColor.ui.shadow,
                              //   width: 110,
                              //   height: 90,
                              // ),
                              // SizedBox(width: 10),
                              // Container(
                              //   color: AppColor.ui.shadow,
                              //   width: 110,
                              //   height: 90,
                              // ),
                              // SizedBox(width: 10),
                              // Container(
                              //   color: AppColor.ui.shadow,
                              //   width: 110,
                              //   height: 90,
                              // ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
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
                  Text(
                    '@ガリバタコーン',
                    style: TextStyle(
                        fontSize: 12, color: AppColor.brand.secondary),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
