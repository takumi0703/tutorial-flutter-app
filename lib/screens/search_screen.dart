import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_search_app/models/article.dart';
import 'package:qiita_search_app/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override

  List<Article> articles = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            // symmetric で、縦方向(vertical)に12px、横方向(horizontal)に36pxのpaddingを設定
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
            child: TextField(
              style: TextStyle(fontSize: 18,color: Colors.black),
              decoration: const InputDecoration(hintText: '検索キーワードを入力してください'),
              onSubmitted: (String value) async {
                // 検索API関数を呼び出し、結果を状態管理できる変数に代入
                final results = await searchQiita(value);
                setState(()=> articles = results);
              },
            ),
          ),
          // 結果一覧
          const ArticleContainer(),
        ],
      )
    );
  }
}

Future<List<Article>> searchQiita(String keyword) async {
  // 1. http通信に必要なデータを準備をする
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
  });
  // ?? '' は、もしdotenv.env['QIITA_ACCESS_TOKEN']がnullだった場合、空文字を返す
  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

  // 2. Qiita APIにリクエストを送る
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  // 3. 戻り値をArticleクラスの配列に変換
  // 4. 変換したArticleクラスの配列を返す(returnする)
  if (res.statusCode == 200) {
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}