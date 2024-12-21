import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VeryStupidFileDownloader {

  late List<int> _fileBytes = [];
  final int _soundId = 14854;

  Future<void> _downloadSound() async {
    const String apiKey = '5zWMuCdS8utgUySktNvB5A1QdWEU8o';
    final String downloadUrl =
        'https://freesound.org/apiv2/sounds/$_soundId/download/';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
    };

    try {
      final response = await http.get(Uri.parse(downloadUrl), headers: headers);

      if (response.statusCode == 200) {
        _fileBytes = response.bodyBytes;
      } else {
        print('Ошибка при скачивании: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  Future<void> _saveSound() {
    return Future.delayed(const Duration(seconds: 1), () {
      Future<Directory?> directory;

      // Получаем путь для сохранения
      if (Platform.isAndroid || Platform.isIOS) {
        directory = getApplicationDocumentsDirectory();
      } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
        directory = getApplicationSupportDirectory();
      } else {
        throw UnsupportedError('Сохранение файлов не поддерживается на этой платформе');
      }
      directory.then((onValue){
        String? path = onValue?.path;
        if (path == null) {
          return;
        }
        final file = File('$path/downloaded_sound_$_soundId.wav');
        file.writeAsBytes(_fileBytes);
      });
      directory.catchError((onError)
      {throw UnsupportedError('Сохранение файлов не поддерживается на этой платформе');});
        });
  }

  void stupid(){
    _downloadSound();
    Future<void> save = _saveSound();
    save.then((value) => print('Скачивание успешно'));
    save.catchError((error) => print('Ошибка при скачивании: $error'));
  }
}
