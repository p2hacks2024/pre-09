class WrongData {
  final String word;
  final int wrongCount;

  WrongData({
    required this.word,
    required this.wrongCount,
  });

  // JSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'wrongCount': wrongCount,
    };
  }

  // JSONからインスタンスを生成するメソッド
  factory WrongData.fromJson(Map<String, dynamic> json) {
    return WrongData(
      word: json['word'],
      wrongCount: json['wrongCount'],
    );
  }
}
