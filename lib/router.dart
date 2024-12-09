import 'package:ebidence/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'title',
      builder: (context, state) => const MyHomePage(
        title: 'screen_transition',
      ),
    ),
  ],
);
