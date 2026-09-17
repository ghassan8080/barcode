package com.example.billing_app;

import android.content.Context;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Locale;

/**
 * Helper for formatting receipt lines and encoding Arabic text for ESC/POS thermal printers.
 */
public class ReceiptPrinterHelper {

    /**
     * Formats a single receipt total line replacing hardcoded currency symbols with dynamic symbol.
     * Example: "المجموع الكلي: 1250.00 د.ع"
     */
    public static String formatTotalLine(Context context, String label, double amount) {
        String symbol = CurrencyManager.getInstance(context).getCurrencySymbol();
        String formattedAmount = String.format(Locale.US, "%.2f", amount);
        return String.format(Locale.getDefault(), "%s: %s %s\n", label, formattedAmount, symbol);
    }

    /**
     * Formats an item line for receipt printing.
     */
    public static String formatItemLine(Context context, String itemName, int qty, double price, double total) {
        String symbol = CurrencyManager.getInstance(context).getCurrencySymbol();
        String formattedPrice = String.format(Locale.US, "%.2f", price);
        String formattedTotal = String.format(Locale.US, "%.2f", total);
        return String.format(Locale.getDefault(), "%dx %s  %s  %s %s\n", qty, itemName, formattedPrice, formattedTotal, symbol);
    }

    /**
     * Converts receipt text to bytes safe for Arabic ESC/POS printers.
     * Tries windows-1256 (standard CP1256 Arabic thermal code page), falling back to UTF-8.
     */
    public static byte[] getPrintableArabicBytes(String text) {
        try {
            return text.getBytes("windows-1256");
        } catch (Exception e) {
            return text.getBytes(StandardCharsets.UTF_8);
        }
    }
}
