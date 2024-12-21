import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bottom_bar/bottom_bar.dart';
import '../delegate/article.dart';

class ArticleCreationPage extends ConsumerStatefulWidget {
  const ArticleCreationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleCreationPageState();
}

class _ArticleCreationPageState extends ConsumerState<ArticleCreationPage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Устанавливаем начальный текст из состояния, если оно уже есть
    final text = ref.read(articleProvider);
    // textController.text = text;
  }

  @override
  void dispose() {
    textController.dispose(); // Освобождаем контроллер при удалении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Article"),
      ),
      bottomNavigationBar: const MyBottomBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // Смещение тени
                  ),
                ],
              ),
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  // Обновляем текст в провайдере при изменении в TextField
                  // ref.read(articleProvider.notifier).update(text);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter text...',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Очистка текста в провайдере и в поле
                      // ref.read(articleProvider.notifier).update("");
                    },
                    child: const Icon(Icons.delete_forever),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.post_add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
