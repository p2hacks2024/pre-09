import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

class SendFirebase extends StatefulWidget {
  const SendFirebase({super.key});

  @override
  State<SendFirebase> createState() => _SendFirebaseState();
}

class _SendFirebaseState extends State<SendFirebase> {
  final storageRef = FirebaseStorage.instance.ref();
  late final Reference containerRef;

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  // FirestoreのドキュメントIDを保持する変数
  String? _docId;

  @override
  void initState() {
    super.initState();
    containerRef = storageRef.child("container_image.jpg");
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

  Future<void> uploadContainerImageAndSaveToFirestore() async {
    try {
      // Containerを画像としてキャプチャ
      Uint8List containerImage = await _captureContainerAsImage();

      // Firebase Storage にアップロード
      await containerRef.putData(containerImage);

      // アップロードされた画像のダウンロードURLを取得
      final String downloadUrl = await containerRef.getDownloadURL();

      // Firestore に保存し、DocumentReferenceを取得
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('images')
          .add({'url': downloadUrl});

      setState(() {
        _docId = docRef.id; // ドキュメントIDを状態変数に保存
      });

      // デバッグコンソールにドキュメントIDを表示
      debugPrint('Firestoreに保存したドキュメントID: ${docRef.id}');

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _repaintBoundaryKey,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/2d00f709f9ffc6434801ec32fa056089.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: uploadContainerImageAndSaveToFirestore,
              child: const Text('ContainerをアップロードしてFirestoreに保存'),
            ),
            TextButton(
              onPressed: _docId == null
                  ? null
                  : () {
                      context.go('/result/${_docId}', extra: _docId);
                    },
              child: const Text('結果画面に遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
