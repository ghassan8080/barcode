package com.example.billing_app;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

/**
 * Settings Activity for selecting and persisting Arab currencies.
 */
public class CurrencySettingsActivity extends Activity {

    private Spinner spinnerCurrencies;
    private Button btnSaveCurrency;
    private CurrencyManager currencyManager;

    private static final String[] CURRENCY_OPTIONS = new String[]{
            "د.ع (دينار عراقي)",
            "ر.س (ريال سعودي)",
            "ج.م (جنيه مصري)",
            "د.إ (درهم إماراتي)"
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_currency_settings);

        currencyManager = CurrencyManager.getInstance(this);

        spinnerCurrencies = findViewById(R.id.spinnerCurrencies);
        btnSaveCurrency = findViewById(R.id.btnSaveCurrency);

        setupCurrencySpinner();

        btnSaveCurrency.setOnClickListener(v -> saveSelectedCurrency());
    }

    private void setupCurrencySpinner() {
        ArrayAdapter<String> adapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_spinner_item,
                CURRENCY_OPTIONS
        );
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerCurrencies.setAdapter(adapter);

        // Pre-select current active currency
        String currentSymbol = currencyManager.getCurrencySymbol();
        for (int i = 0; i < CURRENCY_OPTIONS.length; i++) {
            if (CURRENCY_OPTIONS[i].startsWith(currentSymbol)) {
                spinnerCurrencies.setSelection(i);
                break;
            }
        }
    }

    private void saveSelectedCurrency() {
        String selectedItem = (String) spinnerCurrencies.getSelectedItem();

        if (selectedItem != null && !selectedItem.isEmpty()) {
            // Split string and isolate only the currency symbol (e.g., "د.ع")
            String symbolOnly = selectedItem.split("\\s*\\(")[0].trim();

            currencyManager.saveCurrencySymbol(symbolOnly);

            // Arabic toast notification upon success
            Toast.makeText(this, "تم حفظ العملة بنجاح: " + symbolOnly, Toast.LENGTH_SHORT).show();
            finish();
        }
    }
}
