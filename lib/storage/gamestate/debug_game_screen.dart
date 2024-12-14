import 'package:flutter/material.dart';
import 'game_data_handler.dart'; // GameDataHandlerクラスのパスを調整してください
import 'game_state.dart'; // GameStateとWrongAnswerクラスのパスを調整してください

class DebugGameScreen extends StatefulWidget {
  @override
  _DebugGameScreenState createState() => _DebugGameScreenState();
}

class _DebugGameScreenState extends State<DebugGameScreen> {
  GameState? _loadedGameState;

  // データの保存
  Future<void> _saveGameState() async {
    GameState testState = GameState(
      isGameActive: true,
      qNum: 4,
      qList: ["apple", "banana", "cherry", "peach", "orange"],
      score: 1,
      answerHistory: ["grape", "kiwi", "cherry"],
      qWrongList: [
        WrongAnswer(questionIndex: 1, wrongAnswer: "grape"),
        WrongAnswer(questionIndex: 2, wrongAnswer: "kiwi"),
      ],
    );
    await GameDataHandler.saveGameState(testState);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ゲーム状態を保存しました！")),
    );
  }

  // データの読み込み
  Future<void> _loadGameState() async {
    GameState? state = await GameDataHandler.loadGameState();
    setState(() {
      _loadedGameState = state;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state != null ? "ゲーム状態を読み込みました！" : "保存されたゲーム状態がありません。",
        ),
      ),
    );
  }

  // データのクリア
  Future<void> _clearGameState() async {
    await GameDataHandler.clearGameState();
    setState(() {
      _loadedGameState = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ゲーム状態をクリアしました！")),
    );
  }

  // 読み込んだゲーム状態を表示するウィジェット
  Widget _buildGameStateView() {
    if (_loadedGameState == null) {
      return Text("ゲーム状態はロードされていません。");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ゲーム進行中: ${_loadedGameState!.isGameActive}"),
        Text("現在の問題番号: ${_loadedGameState!.qNum}"),
        Text("問題リスト: ${_loadedGameState!.qList.join(", ")}"),
        Text("スコア: ${_loadedGameState!.score}"),
        Text("回答履歴: ${_loadedGameState!.answerHistory.join(", ")}"),
        Text("間違えた問題:"),
        ..._loadedGameState!.qWrongList.map(
          (wrong) => Text("  Q${wrong.questionIndex}: ${wrong.wrongAnswer}"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ゲームデータデバッグ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _saveGameState,
              child: Text("ゲーム状態を保存"),
            ),
            ElevatedButton(
              onPressed: _loadGameState,
              child: Text("ゲーム状態を読み込み"),
            ),
            ElevatedButton(
              onPressed: _clearGameState,
              child: Text("ゲーム状態をクリア"),
            ),
            SizedBox(height: 20),
            _buildGameStateView(),
          ],
        ),
      ),
    );
  }
}
