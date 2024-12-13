import 'package:ebidence/view/start_page.dart';
import 'package:ebidence/firebase_options.dart';
import 'package:ebidence/function/gif_recorder.dart';
import 'package:ebidence/function/x_share.dart';
import 'package:ebidence/view/developer/send_firebase.dart';
import 'package:ebidence/viewmodel/quiz1.dart';
import 'package:ebidence/routes.dart';
import 'package:ebidence/viewmodel/quiz2.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      // アプリ全体をProviderScopeでラップ
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'evidence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        fontFamily: 'Inter',
        fontFamilyFallback: ['NotoSansJP'],
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
