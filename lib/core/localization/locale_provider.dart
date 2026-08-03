import 'package:avora/core/constants/pref_keys.dart';
import 'package:avora/core/helper/shared_pref_helper.dart';
import 'package:flutter/material.dart';
class LocaleProvider extends ChangeNotifier {
  /// Null means the app follows the system language.
  Locale? _locale;

  Locale? get locale => _locale;

  String? get languageCode => _locale?.languageCode;

  LocaleProvider() {
    _loadLocale();
  }

  void _loadLocale() {
    final savedLanguage = SharedPrefHelper.getString(
      PrefKeys.language,
    );

    if (savedLanguage != null) {
      _locale = Locale(savedLanguage);
    }

    notifyListeners();
  }

  Future<void> changeLanguage(
    String languageCode,
  ) async {
    if (_locale?.languageCode == languageCode) {
      return;
    }

    _locale = Locale(languageCode);

    await SharedPrefHelper.setData(
      PrefKeys.language,
      languageCode,
    );

    notifyListeners();
  }

  Future<void> useSystemLanguage() async {
    _locale = null;

    await SharedPrefHelper.removeData(
      PrefKeys.language,
    );

    notifyListeners();
  }
}