/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Formats a raw ingredient quantity for display.
 *
 * Ingredient and inventory quantities are always stored in base units
 * (grams, millilitres) so the math elsewhere in the app stays simple.
 * But showing someone "1730.0 g" or "851.0 g" on a shopping list is hard
 * to read at a glance - this class converts anything at or above 1000 g
 * or 1000 ml into kilograms/litres for display only. The stored value
 * and all calculations (shortfall, purchase rounding, etc.) are
 * untouched; this is purely a presentation helper.
 *
 * Piece-based units (e.g. "pcs") are left as whole numbers, since there's
 * no larger unit to convert them to.
 */
public final class QuantityFormatter {

    private static final double BULK_CONVERSION_THRESHOLD = 1000;

    private QuantityFormatter() {
        // utility class - not instantiable
    }

    /**
     * Returns a human-friendly "quantity unit" string, e.g. "1.73 kg"
     * instead of "1730.0 g", or "167 ml" unchanged when it's already a
     * comfortable size.
     */
    public static String format(double quantity, String unit) {

        if (unit == null) {
            return trimTrailingZeros(quantity);
        }

        String normalized = unit.trim().toLowerCase();

        if (normalized.equals("g") && quantity >= BULK_CONVERSION_THRESHOLD) {
            return trimTrailingZeros(quantity / BULK_CONVERSION_THRESHOLD) + " kg";
        }

        if (normalized.equals("ml") && quantity >= BULK_CONVERSION_THRESHOLD) {
            return trimTrailingZeros(quantity / BULK_CONVERSION_THRESHOLD) + " L";
        }

        return trimTrailingZeros(quantity) + " " + unit;
    }

    /** Rounds to 2 decimal places and drops any trailing zeros (e.g. 1.70 -> 1.7, 2.00 -> 2). */
    private static String trimTrailingZeros(double value) {
        BigDecimal rounded = BigDecimal.valueOf(value)
                .setScale(2, RoundingMode.HALF_UP)
                .stripTrailingZeros();

        // stripTrailingZeros() can leave a BigDecimal with negative scale
        // (e.g. 100 -> 1E+2), which toPlainString() still renders correctly,
        // so no extra handling is needed here.
        return rounded.toPlainString();
    }
}
