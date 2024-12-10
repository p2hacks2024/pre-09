import 'package:ebidence/function/ogp_link.dart';
import 'package:ebidence/main.dart';
import 'package:ebidence/view/developer/send_firebase.dart';
import 'package:ebidence/view/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: navigatorKey, routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const SendFirebase();
      }),
  GoRoute(
      path: '/result',
      builder: (context, state) {
        final String imageId = state.extra as String? ?? '不明なID';
        return ResultPage(imageId: imageId);
      }),
]);
