package com.example.billing_app;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Singleton manager for local currency persistence via SharedPreferences.
 * Supports Arab currencies with default fallback to Iraqi Dinar (د.ع).
 */
public class CurrencyManager {

    private static final String PREFS_NAME = "app_currency_prefs";
    private static final String KEY_ACTIVE_CURRENCY = "active_currency_symbol";

    // Default fallback currency: Iraqi Dinar (د.ع)
    public static final String DEFAULT_CURRENCY = "د.ع";

    private static volatile CurrencyManager instance;
    private final SharedPreferences sharedPreferences;

    private CurrencyManager(Context context) {
        this.sharedPreferences = context.getApplicationContext()
                .getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
    }

    public static CurrencyManager getInstance(Context context) {
        if (instance == null) {
            synchronized (CurrencyManager.class) {
                if (instance == null) {
                    instance = new CurrencyManager(context);
                }
            }
        }
        return instance;
    }

    /**
     * Saves the selected currency symbol (e.g., "د.ع", "ر.س", "ج.م").
     */
    public void saveCurrencySymbol(String symbol) {
        String cleanSymbol = (symbol != null && !symbol.trim().isEmpty())
                ? symbol.trim()
                : DEFAULT_CURRENCY;
        sharedPreferences.edit()
                .putString(KEY_ACTIVE_CURRENCY, cleanSymbol)
                .apply();
    }

    /**
     * Retrieves the stored active currency symbol, falling back to Iraqi Dinar (د.ع).
     */
    public String getCurrencySymbol() {
        return sharedPreferences.getString(KEY_ACTIVE_CURRENCY, DEFAULT_CURRENCY);
    }
}
