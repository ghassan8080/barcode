import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:billing_app/core/localization/locale_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleCubit Tests', () {
    test('initial locale defaults to English or Arabic', () {
      final cubit = LocaleCubit();
      expect(cubit.state, isA<Locale>());
      expect(['en', 'ar'].contains(cubit.state.languageCode), isTrue);
    });

    test('toggleLocale switches between en and ar', () {
      final cubit = LocaleCubit();
      cubit.setLocale(const Locale('en'));
      expect(cubit.state.languageCode, 'en');
      expect(cubit.isArabic, isFalse);

      cubit.toggleLocale();
      expect(cubit.state.languageCode, 'ar');
      expect(cubit.isArabic, isTrue);

      cubit.toggleLocale();
      expect(cubit.state.languageCode, 'en');
      expect(cubit.isArabic, isFalse);
    });
  });
}
