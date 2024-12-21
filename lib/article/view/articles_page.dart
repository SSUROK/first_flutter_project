import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../bottom_bar/bottom_bar.dart';
import 'article_full_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegate/article.dart';



class ArticlesPage extends ConsumerWidget {
  ArticlesPage({super.key});

  final bool showText = Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold (
        appBar: AppBar(
        backgroundColor: Colors.blue,
          title: const Text('Статьи'),
    ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_forward),
      //   onPressed: () { context.go('/chats'); },),
      bottomNavigationBar: const MyBottomBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            flex: showText ? 1 : 3,
            child:
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
              ),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return GestureDetector(
                    key: ValueKey(index),
                  onTap: () => {
                      ref.read(articleProvider.notifier).update('Article $index', 'bla bla bla', 'surok', index),
                      context.pushReplacementNamed('Article')},
                  child:
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent, // цвет фона
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Article ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ));
                },
                padding: const EdgeInsets.all(10),
                )
          ),
          showText ?
              Expanded(
                  flex: 2,
                  child:
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent, // цвет фона
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const Text(
                        'Very long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long article text here',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                      )
                  ) ) :
              Expanded(
              flex: 0,
                child: Container()
              )
      ]
        ));
  }
}