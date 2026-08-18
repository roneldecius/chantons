import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _isHighContrast = false;
  double _textSizeMultiplier = 1.0;
  String _languageCode = 'fr'; // 'fr' for French, 'ht' for Haitian Creole

  bool get isHighContrast => _isHighContrast;
  double get textSizeMultiplier => _textSizeMultiplier;
  String get languageCode => _languageCode;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isHighContrast = prefs.getBool('isHighContrast') ?? false;
    _textSizeMultiplier = prefs.getDouble('textSizeMultiplier') ?? 1.2;
    _languageCode = prefs.getString('languageCode') ?? 'fr';
    notifyListeners();
  }

  Future<void> setHighContrast(bool value) async {
    _isHighContrast = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHighContrast', value);
    notifyListeners();
  }

  Future<void> setTextSizeMultiplier(double value) async {
    _textSizeMultiplier = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSizeMultiplier', value);
    notifyListeners();
  }

  Future<void> setLanguageCode(String value) async {
    _languageCode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', value);
    notifyListeners();
  }
}
