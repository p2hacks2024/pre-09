import 'dart:convert';

import 'package:ebidence/storage/wrong_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrongStorage extends StatefulWidget {
  const WrongStorage({super.key, required this.title});
  final String title;

  @override
  State<WrongStorage> createState() => _WrongStorageState();
}

class _WrongStorageState extends State<WrongStorage> {
  List<WrongData> _wrongDataList = [];
  List<String> _multiplesOfThreeWords = []; // 3の倍数のwordを表示するためのリスト

  // データを保存する
  Future<void> _saveWrongData() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //保存されているデータにアクセス
    final jsonList =
        _wrongDataList.map((data) => data.toJson()).toList(); //ListをJSONに変換
    await prefs.setString('wrongDataList', jsonEncode(jsonList)); //保存できる形にする
  }

  // データを読み込む
  Future<void> _loadWrongData() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //保存されているデータにアクセス
    final jsonString =
        prefs.getString('wrongDataList'); //key(wrongDataList)に対応する文字列の取得
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>; //JSONをListに変換
      //setState:Stateが変更したらUIを再構築する
      setState(() {
        _wrongDataList = jsonList
            .map((json) => WrongData.fromJson(json as Map<String, dynamic>))
            .toList();
      });
    }
  }

  // 指定されたwordのデータを更新または追加
  void _incrementCounter(String word) {
    setState(() {
      final existingIndex = _wrongDataList
          .indexWhere((data) => data.word == word); //wordが一致するデータの位置(なかったら-1)

      if (existingIndex != -1) {
        // 既存データがある場合、カウントを増加
        _wrongDataList[existingIndex] = WrongData(
          word: word,
          wrongCount: _wrongDataList[existingIndex].wrongCount + 1,
        );
      } else {
        // 新規データを追加
        _wrongDataList.add(WrongData(word: word, wrongCount: 1));
      }
      _updateMultiplesOfThreeWords(); // 3の倍数のデータを更新
    });
    _saveWrongData();
  }

  // 3の倍数のデータを更新
  void _updateMultiplesOfThreeWords() {
    _multiplesOfThreeWords = _wrongDataList
        .where((data) => data.wrongCount % 3 == 0)
        .map((data) => data.word)
        .toList();
  }

  // 全データをクリア
  Future<void> _clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('wrongDataList');
    setState(() {
      _wrongDataList.clear();
      _multiplesOfThreeWords.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWrongData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _wrongDataList.length,
              itemBuilder: (context, index) {
                final data = _wrongDataList[index];
                Color textColor = Colors.black;
                if (data.wrongCount % 3 == 0) {
                  textColor = Colors.red;
                }
                return ListTile(
                  title: Text(
                    data.word,
                    style: TextStyle(color: textColor),
                  ),
                  subtitle: Text('Wrong Count: ${data.wrongCount}'),
                );
              },
            ),
          ),

          // 3の倍数のwordを表示
          if (_multiplesOfThreeWords.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.yellow[100],
              child: Column(
                children: [
                  const Text(
                    'Words with Wrong Count as Multiples of 3:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ..._multiplesOfThreeWords.map((word) => Text(word)).toList(),
                ],
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _incrementCounter('counter1'),
                child: const Text('Increment Counter1'),
              ),
              ElevatedButton(
                onPressed: () => _incrementCounter('counter2'),
                child: const Text('Increment Counter2'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _clearData,
            child: const Text('Clear All Data'),
          ),
        ],
      ),
    );
  }
}
