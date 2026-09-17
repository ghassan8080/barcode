import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_manager.dart';

class CurrencyCubit extends Cubit<String> {
  final CurrencyManager _currencyManager;

  CurrencyCubit({CurrencyManager? currencyManager})
      : _currencyManager = currencyManager ?? CurrencyManager(),
        super(currencyManager?.getActiveCurrency() ?? CurrencyManager().getActiveCurrency());

  void setCurrency(String symbol) async {
    final cleanSymbol = symbol.trim().isEmpty ? CurrencyManager.defaultCurrency : symbol.trim();
    if (state == cleanSymbol) return;
    await _currencyManager.saveCurrency(cleanSymbol);
    emit(cleanSymbol);
  }

  String format(double amount) {
    return CurrencyManager.formatPrice(amount, state);
  }
}
