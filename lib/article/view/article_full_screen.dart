import 'package:first_flutter_project/article/view/articles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../bottom_bar/bottom_bar.dart';
import '../delegate/article.dart';

class ArticleFullScreen extends ConsumerWidget {
  const ArticleFullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleProvider);
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.blue,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Статья ${article.title}'),
          centerTitle: true,
          actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back), // Иконка назад
            onPressed: () {
            context.pop();
            },
          )
          ],
        ),
        bottomNavigationBar: const MyBottomBar(),
          body:
          Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent, // цвет фона
                borderRadius: BorderRadius.circular(20),
              ),
            child:Text(
              'Статья ${article.content}',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
            ) )
    );
  }
}