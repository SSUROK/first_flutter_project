import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ключ для сохранения темы
const themePreferenceKey = 'isDarkTheme';

// Асинхронный провайдер для SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Провайдер для темы
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  return ThemeNotifier(prefs);
});

class ThemeNotifier extends StateNotifier<bool> {
  final SharedPreferences? prefs;

  ThemeNotifier(this.prefs) : super(prefs?.getBool(themePreferenceKey) ?? false);

  // Метод для переключения темы
  void toggleTheme() {
    state = !state;
    prefs?.setBool(themePreferenceKey, state);
  }
}
