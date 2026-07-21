package util;

import jakarta.servlet.ServletContext;

import java.io.File;

/**
 * Matches a recipe's name to an image file that lives in /web/images,
 * so recipes can use locally-hosted photos instead of (or as a fallback
 * for) an externally-stored imageUrl.
 *
 * Matching is case-insensitive on the file's base name (extension
 * stripped), since some image files use different casing than the
 * recipe name stored in the database (e.g. "Chicken curry with sauce.png"
 * for a recipe named "Chicken Curry With Sauce").
 */
public class RecipeImageResolver {

    private static final String[] EXTENSIONS = { ".png", ".jpg", ".jpeg", ".webp" };

    /**
     * @param context    the ServletContext (available as "application" in a JSP)
     * @param recipeName the recipe's name to match against files in /web/images
     * @return a context-relative path such as "images/Grilled Salmon.png",
     *         or null if no matching local image was found
     */
    public static String resolve(ServletContext context, String recipeName) {

        if (context == null || recipeName == null || recipeName.trim().isEmpty()) {
            return null;
        }

        String imagesRealPath = context.getRealPath("/images");

        if (imagesRealPath == null) {
            return null;
        }

        File imagesDir = new File(imagesRealPath);
        File[] files = imagesDir.listFiles();

        if (files == null) {
            return null;
        }

        String targetName = recipeName.trim();

        for (File file : files) {

            String fileName = file.getName();
            int dotIndex = fileName.lastIndexOf('.');

            if (dotIndex <= 0) {
                continue;
            }

            String baseName = fileName.substring(0, dotIndex);
            String extension = fileName.substring(dotIndex).toLowerCase();

            if (!isSupportedExtension(extension)) {
                continue;
            }

            if (baseName.equalsIgnoreCase(targetName)) {
                return "images/" + fileName;
            }
        }

        return null;
    }

    private static boolean isSupportedExtension(String extension) {

        for (String supported : EXTENSIONS) {
            if (supported.equals(extension)) {
                return true;
            }
        }

        return false;
    }
}
