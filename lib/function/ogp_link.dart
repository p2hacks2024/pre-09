import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OgpLink extends StatelessWidget {
  const OgpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('OgpLink'),
          Image(image: AssetImage('assets/images/lgtm_cat.gif')),
          TextButton(
              onPressed: (() {
                context.go('/result');
              }),
              child: Text('遷移ボタン')),
        ],
      ),
    );
  }
}
