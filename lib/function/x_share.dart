import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class XShare extends StatelessWidget {
  final String text;
  final String url;
  final List<String> hashtags;
  final String via;
  final String related;

  const XShare({
    Key? key,
    required this.text,
    this.url = "",
    this.hashtags = const [],
    this.via = "",
    this.related = "",
  }) : super(key: key);

  Future<void> _tweet() async {
    // Twitterアプリを開くためのURIスキーム
    final Uri tweetScheme = Uri.parse(
      "twitter://post?text=${Uri.encodeComponent(text)}",
    );

    // TwitterウェブURL
    final Uri tweetIntentUrl = Uri.https(
      "twitter.com",
      "/intent/tweet",
      {
        "text": text,
        "url": url,
        "hashtags": hashtags.join(","),
        "via": via,
        "related": related,
      },
    );

    // Twitterアプリがインストールされているか確認
    if (await canLaunchUrl(tweetScheme)) {
      await launchUrl(tweetScheme);
    } else if (await canLaunchUrl(tweetIntentUrl)) {
      // インストールされていない場合はブラウザで開く
      await launchUrl(tweetIntentUrl);
    } else {
      // どちらも開けない場合はエラーメッセージを表示
      throw Exception("Could not launch Twitter URL.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.share),
      backgroundColor: Colors.lightBlueAccent,
      onPressed: _tweet,
    );
  }
}
