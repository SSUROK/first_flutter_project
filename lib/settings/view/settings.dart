import 'dart:io';

import 'package:first_flutter_project/album/view/settings_btn.dart';
import 'package:first_flutter_project/settings/data/shared_preferences_puller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bottom_bar/bottom_bar.dart';
import '../../../apis/free_sound.dart';
import '../data/provider.dart';

class SettingsScreen extends ConsumerWidget {
  // final VoidCallback onThemeToggle;
  // final ValueChanged<Color> onColorChange;

  const SettingsScreen({
    super.key,
    // required this.onThemeToggle,
    // required this.onColorChange,
  });

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT, // Длительность показа
        gravity: ToastGravity.BOTTOM,      // Позиция (например, BOTTOM, CENTER, TOP)
        backgroundColor: Colors.black,     // Цвет фона
        textColor: Colors.white,            // Цвет текста
        fontSize: 16.0                      // Размер шрифта
    );
  }

  void notificationTest({msg = "Это сообщение Toast!"}){
    if (Platform.isAndroid) {
      _showToast(msg);
    } else if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    SharedPreferencePuller sharesInst = GetIt.I<SharedPreferencePuller>();
    final shares = sharesInst.fetchSharedPreferences();
    VeryStupidFileDownloader vsfd = GetIt.I<VeryStupidFileDownloader>();
    return Scaffold (
        appBar: AppBar(
        backgroundColor: Colors.blue,
          title: const Text('Чаты'),
    ),
    // floatingActionButton: FloatingActionButton(
    // child: Icon(Icons.arrow_forward),
    // onPressed: () { context.go('/library'); },),
        bottomNavigationBar: const MyBottomBar(),
      body:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Текущая тема: ${isDarkTheme ? "Тёмная" : "Светлая"}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Переключаем тему
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    child: const Text("Переключить тему"),
                  ),
                ],
              ),
              // SettingsBtn(shares: shares,
              //     buttonText: 'Переключить тему',
              //     onPressed: ref.read(themeProvider.notifier).toggleTheme,
              //     skey: 'darkTheme',
              //     value: true
              // ),
              // Padding(padding: const EdgeInsets.all(8.0),
              //   child:
              //   ElevatedButton(
              //     onPressed: () => onColorChange(Colors.red),
              //     child: const Text('Красный AppBar'),
              //   )),
              // Padding(padding: const EdgeInsets.all(8.0),
              //   child:
              //   ElevatedButton(
              //     onPressed: () => onColorChange(Colors.green),
              //     child: const Text('Зеленый AppBar'),
              // )),
              Padding(padding: const EdgeInsets.all(8.0),
                child:
                ElevatedButton(
                  onPressed: () => notificationTest(),
                  child: const Text('Испытать уведомления'),
              )),
              // Padding(padding: const EdgeInsets.all(8.0),
              //   child:
              //   ElevatedButton(
              //     onPressed: () => {
              //       vsfd.stupid()},
              //     child: const Text('Скачать файл'),
              //   )
              // ),
            ],
          )
        ]
      ));
  }
}