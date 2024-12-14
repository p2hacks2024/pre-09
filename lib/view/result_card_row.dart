import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultCardRow extends ConsumerStatefulWidget {
  const ResultCardRow({super.key});

  @override
  ConsumerState<ResultCardRow> createState() => _ResultCardRowState();
}

class _ResultCardRowState extends ConsumerState<ResultCardRow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('aiueo')],
      ),
    );
  }
}
