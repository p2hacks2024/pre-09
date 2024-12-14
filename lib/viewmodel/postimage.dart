import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebidence/constant/app_color.dart';
import 'package:ebidence/constant/quiz_data.dart';
import 'package:ebidence/provider/quiz_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class PostImage extends ConsumerStatefulWidget {
  const PostImage({super.key});

  @override
  ConsumerState<PostImage> createState() => _PostImageState();
}

class _PostImageState extends ConsumerState<PostImage> {
  final storageRef = FirebaseStorage.instance.ref();
  late Reference containerRef;

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  // FirestoreのドキュメントIDを保持する変数
  String? _docId;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _updateContainerRef();
    debugPrint('a');
    //_uploadContainerImageAndSaveToFirestore();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await _uploadContainerImageAndSaveToFirestore();
    // });
    debugPrint('b');
  }

  /// 現在のタイムスタンプを用いてReferenceを更新
  void _updateContainerRef() {
    final String timestamp =
        DateFormat('yyyy_MM_dd_HH_mm_ss_SSS').format(DateTime.now());
    containerRef = storageRef.child("$timestamp.jpg");
  }

  /// Containerを画像としてレンダリングし、Uint8List形式で取得
  Future<Uint8List> _captureContainerAsImage() async {
    try {
      // RepaintBoundaryのkeyからRenderRepaintBoundaryを取得
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // 描画を画像としてレンダリング
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 画像をByteDataに変換
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      // ByteDataをUint8Listに変換
      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception("画像のレンダリングに失敗しました: $e");
    }
  }

  Future<void> _uploadContainerImageAndSaveToFirestore() async {
    try {
      // タイムスタンプを使用してファイル名を更新
      _updateContainerRef();

      // Containerを画像としてキャプチャ
      Uint8List containerImage = await _captureContainerAsImage();

      // Firebase Storage にアップロード
      await containerRef.putData(
          containerImage,
          SettableMetadata(
            contentType: "image/png",
          ));

      // アップロードされた画像のダウンロードURLを取得
      final String downloadUrl = await containerRef.getDownloadURL();

      // Firestore に保存し、DocumentReferenceを取得
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('images')
          .add({'url': downloadUrl});

      setState(() {
        _docId = docRef.id; // ドキュメントIDを状態変数に保存
      });

      debugPrint('Firestoreに保存したドキュメントID: ${docRef.id}');
      debugPrint('保存した画像名: ${containerRef.name}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存成功！ドキュメントID: ${docRef.id}')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            RepaintBoundary(
              key: _repaintBoundaryKey,
              child: Container(
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
                              borderRadius:
                                  BorderRadius.circular(8), // 角丸をつける場合
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
                                          offset: const Offset(0, 4),
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
                                          offset: const Offset(0, 4), // 下側に影を移動
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
                    const Text(
                      '結果',
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(
                      '全問不正解',
                      style: TextStyle(
                        fontSize: 107, //'全'が潰れない最大値
                        fontFamily: 'NotoSansJP-Bold',
                        color: AppColor.text.black,
                      ),
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
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++) ...[
                                  Container(
                                    width: 110,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
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
                                                color: Colors.red,
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (i < 4) const SizedBox(width: 10),
                                ],
                              ],
                            )
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
                    Text(
                      '@ガリバタコーン',
                      style: TextStyle(
                          fontSize: 12, color: AppColor.brand.secondary),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _uploadContainerImageAndSaveToFirestore();
              },
              child: const Text('ContainerをアップロードしてFirestoreに保存'),
            ),
          ],
        ),
      ),
    );
  }
}
