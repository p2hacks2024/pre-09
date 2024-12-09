import 'dart:convert';
import 'package:ebidence/storage/gamestate/game_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameDataHandler {
  // データを保存
  static Future<void> saveGameState(GameState gameState) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(gameState.toJson());
      await prefs.setString('gameState', jsonString);
    } catch (e) {
      print("Error saving game state: $e");
    }
  }

  // データを読み込み
  static Future<GameState?> loadGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('gameState');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return GameState.fromJson(jsonMap);
    }
    return null; // 保存されたデータがない場合
  }

  // データを削除
  static Future<void> clearGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('gameState');
  }

  void testGameStateLogic() async {
    // 保存するテストデータ
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

    // データを保存
    await GameDataHandler.saveGameState(testState);

    // データを読み込み
    GameState? loadedState = await GameDataHandler.loadGameState();

    // 読み込んだデータを出力
    if (loadedState != null) {
      print("isGameActive: ${loadedState.isGameActive}");
      print("qNum: ${loadedState.qNum}");
      print("qList: ${loadedState.qList}");
      print("score: ${loadedState.score}");
      print("answerHistory: ${loadedState.answerHistory}");
      print(
          "wrongQuestions: ${loadedState.qWrongList.map((wrong) => "Q${wrong.questionIndex}: ${wrong.wrongAnswer}").toList()}");
    } else {
      print("ゲーム状態が保存されていません。");
    }
  }
}
