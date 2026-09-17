package com.example.billing_app;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import java.util.Locale;

/**
 * Example POS Sales Activity demonstrating dynamic currency binding in onResume().
 */
public class SalesMainActivity extends Activity {

    private TextView tvTotalPrice;
    private double currentTotalPrice = 1250.75;
    private CurrencyManager currencyManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_currency_settings); // Or main sales layout

        currencyManager = CurrencyManager.getInstance(this);
        tvTotalPrice = findViewById(R.id.tvCurrencyLabel);
    }

    @Override
    protected void onResume() {
        super.onResume();
        // Dynamic fetch of active currency whenever screen resumes
        updateTotalPriceDisplay(currentTotalPrice);
    }

    /**
     * Updates total price TextView dynamically by concatenating double totalPrice
     * with active Arabic currency string safely for RTL layouts.
     */
    private void updateTotalPriceDisplay(double totalPrice) {
        String activeSymbol = currencyManager.getCurrencySymbol();
        String formattedPrice = String.format(Locale.US, "%,.2f", totalPrice);
        String finalOutput = formattedPrice + " " + activeSymbol;

        tvTotalPrice.setText(finalOutput);
    }
}
