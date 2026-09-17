import 'package:flutter/foundation.dart';
import '../data/hive_database.dart';

class CurrencyOption {
  final String symbol;
  final String nameAr;
  final String nameEn;

  const CurrencyOption({
    required this.symbol,
    required this.nameAr,
    required this.nameEn,
  });

  String get labelAr => '$symbol ($nameAr)';
  String get labelEn => '$symbol ($nameEn)';
}

class CurrencyManager {
  static const String keyActiveCurrency = 'active_currency_symbol';
  static const String defaultCurrency = 'د.ع'; // Iraqi Dinar default fallback

  static const List<CurrencyOption> supportedCurrencies = [
    CurrencyOption(symbol: 'د.ع', nameAr: 'دينار عراقي', nameEn: 'Iraqi Dinar'),
    CurrencyOption(symbol: 'ر.س', nameAr: 'ريال سعودي', nameEn: 'Saudi Riyal'),
    CurrencyOption(symbol: 'ج.م', nameAr: 'جنيه مصري', nameEn: 'Egyptian Pound'),
    CurrencyOption(symbol: 'د.إ', nameAr: 'درهم إماراتي', nameEn: 'UAE Dirham'),
    CurrencyOption(symbol: 'د.ك', nameAr: 'دينار كويتي', nameEn: 'Kuwaiti Dinar'),
    CurrencyOption(symbol: 'ر.ق', nameAr: 'ريال قطري', nameEn: 'Qatari Riyal'),
    CurrencyOption(symbol: 'ر.ع', nameAr: 'ريال عماني', nameEn: 'Omani Rial'),
    CurrencyOption(symbol: 'د.أ', nameAr: 'دينار أردني', nameEn: 'Jordanian Dinar'),
    CurrencyOption(symbol: '\$', nameAr: 'دولار أمريكي', nameEn: 'US Dollar'),
  ];

  static final CurrencyManager _instance = CurrencyManager._internal();
  factory CurrencyManager() => _instance;
  CurrencyManager._internal();

  /// Retrieve active currency symbol
  String getActiveCurrency() {
    try {
      final saved = HiveDatabase.settingsBox.get(keyActiveCurrency) as String?;
      if (saved != null && saved.trim().isNotEmpty) {
        return saved.trim();
      }
    } catch (e) {
      debugPrint('Error reading currency from Hive: $e');
    }
    return defaultCurrency;
  }

  /// Save active currency symbol
  Future<void> saveCurrency(String symbol) async {
    final cleanSymbol = symbol.trim().isEmpty ? defaultCurrency : symbol.trim();
    try {
      await HiveDatabase.settingsBox.put(keyActiveCurrency, cleanSymbol);
    } catch (e) {
      debugPrint('Error saving currency to Hive: $e');
    }
  }

  /// Format price safely with active currency symbol
  static String formatPrice(double price, String symbol) {
    return '${price.toStringAsFixed(2)} $symbol';
  }
}
