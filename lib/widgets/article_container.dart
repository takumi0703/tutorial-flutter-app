import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_search_app/models/article.dart';

// 検索結果の記事を表示するウィジェット
class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          // 縦方向に並べる?
          crossAxisAlignment: CrossAxisAlignment.start,
          // 投稿内容
          children: [
            // 投稿日
            Text(
              DateFormat('yyyy/MM/dd').format(article.createdAt),
              style: const TextStyle(color: Colors.white , fontSize: 12),
            ),
            // タイトル
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // 2行以上の場合は省略記号を表示
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // タグ
            Text(
              '#${article.tags.join(' #')}',
              style: const TextStyle(fontSize: 12, color: Colors.white, fontStyle: FontStyle.italic),
            ),
            // 横方向にchild要素並べる
            // いいねとユーザアイコン
            Row(
              // 並べる要素の間隔を均等にする
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.favorite, color: Colors.white,
                    ),
                    Text(
                      article.likesCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 26, backgroundImage: NetworkImage(article.user.profileImageUrl),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.user.id,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}