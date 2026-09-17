import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/hive_database.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _localeKey = 'app_locale';

  LocaleCubit() : super(_getInitialLocale());

  static Locale _getInitialLocale() {
    try {
      final savedLocale = HiveDatabase.settingsBox.get(_localeKey) as String?;
      if (savedLocale != null && savedLocale.isNotEmpty) {
        return Locale(savedLocale);
      }
    } catch (_) {}

    // Default to device locale if Arabic, otherwise fallback to English
    final platformLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (platformLocale.languageCode == 'ar') {
      return const Locale('ar');
    }
    return const Locale('en');
  }

  void setLocale(Locale locale) {
    if (state == locale) return;
    try {
      HiveDatabase.settingsBox.put(_localeKey, locale.languageCode);
    } catch (_) {}
    emit(locale);
  }

  void toggleLocale() {
    if (state.languageCode == 'ar') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('ar'));
    }
  }

  bool get isArabic => state.languageCode == 'ar';
}
