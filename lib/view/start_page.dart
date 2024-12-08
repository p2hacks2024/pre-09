import 'package:flutter/material.dart';

import 'package:ebidence/constant/app_color.dart';
import 'package:ebidence/constant/app_size.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("あいうえお"),
        ],
      ),
    );
  }
}