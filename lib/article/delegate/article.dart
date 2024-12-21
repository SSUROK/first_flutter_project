import 'package:first_flutter_project/article/model/article_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article.g.dart';

@riverpod
class Article extends _$Article {

  @override
  ArticleModel build() => ArticleModel(title: '', content: '', author: '', id: 0);

  void update(String title, String content, String author, int id) => state = ArticleModel(title: title, content: content, author: author, id: id);
}