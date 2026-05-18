package com.SkolaStudentManagement.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Set;

public class ImageUtil {

    private static final String IMAGE_DIR      = "uploads/profile_images";
    private static final long   MAX_SIZE_BYTES = 5 * 1024 * 1024; // 5 MB
    private static final Set<String> ALLOWED_TYPES = Set.of(
            "image/jpeg", "image/png", "image/gif", "image/webp"
    );

    // ── Upload ────────────────────────────────────────────────────────

    /**
     * Validates, saves the file, deletes the old one, and returns the
     * relative path to store in the DB  (e.g. "uploads/profile_images/student_3_172000.jpg").
     * Returns null if validation fails.
     */
    public static String upload(Part filePart, String oldImagePath,
                                ServletContext ctx) throws IOException {

        if (!isValid(filePart)) return null;

        String savePath = ctx.getRealPath("") + File.separator + IMAGE_DIR;
        new File(savePath).mkdirs();

        String fileName = buildFileName(filePart);
        filePart.write(savePath + File.separator + fileName);

        // Delete old image from disk after new one is saved successfully
        deleteFromDisk(oldImagePath, ctx);

        return IMAGE_DIR + "/" + fileName;
    }

    // ── Delete ────────────────────────────────────────────────────────

    /**
     * Deletes an image from disk given its relative path
     * (e.g. "uploads/profile_images/student_3_172000.jpg").
     */
    public static void deleteFromDisk(String relativePath, ServletContext ctx) {
        if (relativePath == null || relativePath.isEmpty()) return;
        File file = new File(ctx.getRealPath("") + File.separator + relativePath);
        if (file.exists()) file.delete();
    }

    // ── Validation ────────────────────────────────────────────────────

    public static boolean isValid(Part filePart) {
        if (filePart == null || filePart.getSize() == 0)         return false;
        if (filePart.getSize() > MAX_SIZE_BYTES)                 return false;
        if (!ALLOWED_TYPES.contains(filePart.getContentType())) return false;
        return true;
    }

    public static String getValidationError(Part filePart) {
        if (filePart == null || filePart.getSize() == 0)         return "Please select an image.";
        if (filePart.getSize() > MAX_SIZE_BYTES)                 return "Image must be under 5 MB.";
        if (!ALLOWED_TYPES.contains(filePart.getContentType())) return "Only JPEG, PNG, GIF and WEBP allowed.";
        return null;
    }

    // ── Private helpers ───────────────────────────────────────────────

    private static String buildFileName(Part filePart) {
        String original  = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = original.contains(".")
                ? original.substring(original.lastIndexOf('.'))
                : "";
        return "student_" + System.currentTimeMillis() + extension;
    }
}