import 'package:ebidence/function/ogp_link.dart';
import 'package:ebidence/main.dart';
import 'package:ebidence/view/developer/send_firebase.dart';
import 'package:ebidence/view/result.dart';
import 'package:ebidence/viewmodel/quiz.dart';
import 'package:ebidence/viewmodel/quiz2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router =
    GoRouter(navigatorKey: navigatorKey, initialLocation: '/quiz', routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const SendFirebase();
      }),
  GoRoute(
      path: '/result/:_imageId',
      builder: (context, state) {
        final imageId = state.pathParameters['_imageId']!;
        if (imageId == null) {
          return Scaffold(
            body: Center(
                child: Text('imageIdがnullなんだけどーー')), // imageIdがnullの場合のエラーメッセージ
          );
        }
        return ResultPage(imageId: imageId);
      }),
  GoRoute(
      path: '/quiz',
      builder: (context, state) {
        return const Quiz();
      }),
  GoRoute(
      path: '/quiz2',
      builder: (context, state) {
        return const quiz2();
      }),
]);