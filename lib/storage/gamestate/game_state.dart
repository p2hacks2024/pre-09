class GameState {
  final bool isGameActive; // ゲームが進行中かどうか
  final int qNum; // 現在の問題番号
  final List<String> qList; // 問題のリスト
  final int score; // 現在のスコア
  final List<String> answerHistory; // 回答履歴
  final List<WrongAnswer> qWrongList; //間違えた問題のリスト

  GameState(
      {required this.isGameActive,
      required this.qNum,
      required this.qList,
      required this.score,
      required this.answerHistory,
      required this.qWrongList});

  // JSONに変換するメソッド
  // qWrongListはWrongAnswer型のリストをJSON形式に変換します
  Map<String, dynamic> toJson() {
    return {
      'isGameActive': isGameActive,
      'qNum': qNum,
      'qList': qList,
      'score': score,
      'answerHistory': answerHistory,
      'qWrongList': qWrongList.map((wrong) => wrong.toJson()).toList(),
    };
  }

  // JSONからインスタンスを生成するメソッド
  factory GameState.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('isGameActive') || !json.containsKey('qWrongList')) {
      throw const FormatException("Invalid GameState JSON");
    }
    return GameState(
      isGameActive: json['isGameActive'],
      qNum: json['qNum'],
      qList: List<String>.from(json['qList']),
      score: json['score'],
      answerHistory: List<String>.from(json['answerHistory']),
      qWrongList: (json['qWrongList'] as List)
          .map((item) => WrongAnswer.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class WrongAnswer {
  final int questionIndex; // 問題番号（インデックス）
  final String wrongAnswer; // 間違えた回答

  WrongAnswer({
    required this.questionIndex,
    required this.wrongAnswer,
  });

  // JSONに変換する
  Map<String, dynamic> toJson() {
    return {
      'questionIndex': questionIndex,
      'wrongAnswer': wrongAnswer,
    };
  }

  // JSONからインスタンスを生成
  factory WrongAnswer.fromJson(Map<String, dynamic> json) {
    return WrongAnswer(
      questionIndex: json['questionIndex'],
      wrongAnswer: json['wrongAnswer'],
    );
  }
}
