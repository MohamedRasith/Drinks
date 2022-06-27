import 'package:flutter/material.dart';
import 'package:drinks/services/local_storage.dart';
import 'package:drinks/utils/helpers.dart';
import 'package:provider/provider.dart';

class ThemeController extends ChangeNotifier {
  static ThemeController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<ThemeController>(context, listen: listen);

  static const _sharedPrefsKey = 'theme';
  static const _fallbackThemeMode = ThemeMode.system;

  ThemeController() {
    _initialize();
  }

  ThemeMode? _themeMode;

  ThemeMode? get themeMode => _themeMode;

  void _initialize() {
    final currentTheme = LocalStorage.read(_sharedPrefsKey);
    _themeMode = _getThemeModeFromString(currentTheme);
    notifyListeners();
  }

  String get currentThemeName => capitalizeFirst(_themeMode!.name);

  ThemeMode _getThemeModeFromString(String? themeString) {
    try {
      return ThemeMode.values.byName(themeString!);
    } catch (_) {
      return _fallbackThemeMode;
    }
  }

  void setThemeString(String theme) {
    final newThemeMode = _getThemeModeFromString(theme);
    _themeMode = newThemeMode;
    LocalStorage.write(_sharedPrefsKey, newThemeMode.name);
    notifyListeners();
  }

// void clear() {
//   _themeMode = null;
//   LocalStorage.remove(_sharedPrefsKey);
//   notifyListeners();
// }
}
