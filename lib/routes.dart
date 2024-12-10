import 'package:ebidence/function/ogp_link.dart';
import 'package:ebidence/main.dart';
import 'package:ebidence/view/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: navigatorKey, routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const OgpLink();
      }),
  GoRoute(
    path: '/result',
    builder: (context, state) => const ResultPage(),
  ),
  // GoRoute(path: '/developer', builder: (context, state) => const DeveloperWidgets()),
  // GoRoute(path: '/register', builder: (context, state) => const RegisterView()),
  // GoRoute(path: '/nickname', builder: (context, state) => const NicknameView()),
  // GoRoute(path: '/login', builder: (context, state) => const LoginView()),
  // GoRoute(path: '/home', builder: (context, state) => const HomeView()),
  // GoRoute(path: '/call', builder: (context, state) => Call()),
  // GoRoute(
  //     path: '/foreground_init',
  //     builder: (context, state) {
  //       return const Splash();
  //     })
]);
