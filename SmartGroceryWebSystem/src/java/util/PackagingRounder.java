/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 * Rounds a raw ingredient shortfall (e.g. "recipe needs 100 g") up to a
 * quantity that's actually purchasable at a store.
 *
 * Products aren't sold loose by the gram or millilitre - the smallest unit
 * on a shelf is typically a whole kilogram or litre. So a need for anything
 * from 1 g up to 1000 g rounds up to a single 1000-unit package; a need for
 * 1200 g rounds up to 2000 g (two packages), and so on.
 *
 * Piece-based units (e.g. "pcs", "slices") aren't sold in bulk packages, so
 * those are left as a plain ceiling of the raw count - you can't buy half an
 * egg, but you also don't round 3 eggs up to a dozen.
 */
public final class PackagingRounder {

    /** Package size, in base units, for anything measured by weight or volume. */
    private static final int BULK_PACKAGE_SIZE = 1000;

    private PackagingRounder() {
        // utility class - not instantiable
    }

    /**
     * Returns how many of the product to actually purchase, given how much
     * is needed and what unit it's measured in.
     */
    public static int roundToPurchaseQuantity(double neededQuantity, String unit) {
        if (neededQuantity <= 0) {
            return 0;
        }

        if (isBulkUnit(unit)) {
            return roundUpToPackage(neededQuantity, BULK_PACKAGE_SIZE);
        }

        // Piece-based units: buy exactly enough, rounded up to a whole item.
        return (int) Math.ceil(neededQuantity);
    }

    /** True for units sold in bulk (weight/volume) rather than as discrete items. */
    private static boolean isBulkUnit(String unit) {
        if (unit == null) {
            return false;
        }
        String normalized = unit.trim().toLowerCase();
        return normalized.equals("g") || normalized.equals("ml");
    }

    /** Rounds up to the next whole multiple of packageSize (never returns less than one package). */
    private static int roundUpToPackage(double neededQuantity, int packageSize) {
        int packages = (int) Math.ceil(neededQuantity / packageSize);
        return Math.max(packages, 1) * packageSize;
    }
}
