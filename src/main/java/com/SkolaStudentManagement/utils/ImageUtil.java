package com.SkolaStudentManagement.utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * General-purpose file upload utility used by all servlets that handle images.
 * Validates size and MIME type, generates a UUID filename, writes to disk,
 * and returns a relative path safe to store in the DB.
 *
 * Usage (profile photo):
 *   String path = ImageUtil.saveImage(part, context.getRealPath(""), ImageUtil.PROFILE_DIR);
 *
 * Usage (announcement attachment):
 *   String path = ImageUtil.saveImage(part, context.getRealPath(""), ImageUtil.ANNOUNCEMENT_DIR);
 */
public class ImageUtil {

    // ── Sub-directory constants ──────────────────────────────────────────────
    /** Profile / student photos */
    public static final String PROFILE_DIR      = "uploads/profiles";
    /** Announcement attachments (images + documents) */
    public static final String ANNOUNCEMENT_DIR = "uploads/announcements";
    /** Generic fallback when no specific folder is needed */
    public static final String DEFAULT_DIR      = "uploads";

    // ── Constraints ──────────────────────────────────────────────────────────
    private static final long MAX_IMAGE_BYTES = 5 * 1024 * 1024;   // 5 MB for photos
    private static final long MAX_FILE_BYTES  = 10 * 1024 * 1024;  // 10 MB for documents

    private static final String[] IMAGE_TYPES = {
        "image/jpeg", "image/png", "image/gif", "image/webp"
    };

    private static final String[] ALL_TYPES = {
        "image/jpeg", "image/png", "image/gif", "image/webp",
        "application/pdf",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.ms-powerpoint",
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    };

    // ── Public API ────────────────────────────────────────────────────────────

    /**
     * Saves an uploaded image (photos only — JPEG, PNG, GIF, WEBP) to the given
     * sub-directory under the webapp root.
     *
     * @param part           the multipart Part from the request
     * @param webappRealPath {@code servletContext.getRealPath("")}
     * @param subDir         one of the DIR constants, e.g. {@code PROFILE_DIR}
     * @return relative path to store in the DB (e.g. "uploads/profiles/abc.jpg"),
     *         or {@code null} if the part was empty (no file chosen)
     * @throws IllegalArgumentException for invalid type or oversized file
     * @throws IOException              for I/O failures during write
     */
    public static String saveImage(Part part, String webappRealPath, String subDir)
            throws IOException {
        return save(part, webappRealPath, subDir, IMAGE_TYPES, MAX_IMAGE_BYTES);
    }

    /**
     * Saves any allowed file type (images + PDF/Word/PowerPoint) to the given
     * sub-directory. Used for announcement attachments.
     *
     * @param part           the multipart Part from the request
     * @param webappRealPath {@code servletContext.getRealPath("")}
     * @param subDir         target sub-directory, e.g. {@code ANNOUNCEMENT_DIR}
     * @return relative path to store in DB, or {@code null} if no file chosen
     */
    public static String saveFile(Part part, String webappRealPath, String subDir)
            throws IOException {
        return save(part, webappRealPath, subDir, ALL_TYPES, MAX_FILE_BYTES);
    }

    /**
     * Backwards-compatible alias kept so existing callers in
     * AnnouncementServlet and EditStudentDetailsServlet continue to compile
     * without changes. Delegates to {@link #saveFile} using ANNOUNCEMENT_DIR.
     *
     * @deprecated Prefer {@link #saveImage} or {@link #saveFile} with an explicit dir.
     */
    @Deprecated
    public static String saveAnnouncementFile(Part filePart, String webappRealPath)
            throws IOException {
        return saveFile(filePart, webappRealPath, ANNOUNCEMENT_DIR);
    }

    /** Returns {@code true} if the stored path ends with an image extension. */
    public static boolean isImage(String path) {
        if (path == null) return false;
        String lower = path.toLowerCase();
        return lower.endsWith(".jpg")  || lower.endsWith(".jpeg")
            || lower.endsWith(".png")  || lower.endsWith(".gif")
            || lower.endsWith(".webp");
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    /**
     * Core upload logic shared by all public methods.
     */
    private static String save(Part part, String webappRealPath,
                                String subDir, String[] allowedTypes, long maxBytes)
            throws IOException {

        if (part == null || part.getSize() == 0) {
            return null; // no file chosen — caller decides on default
        }

        // Size check
        if (part.getSize() > maxBytes) {
            throw new IllegalArgumentException(
                "File too large. Maximum allowed size is " + (maxBytes / (1024 * 1024)) + " MB.");
        }

        // MIME type check
        String contentType = part.getContentType();
        boolean allowed = false;
        if (contentType != null) {
            for (String t : allowedTypes) {
                if (t.equalsIgnoreCase(contentType)) { allowed = true; break; }
            }
        }
        if (!allowed) {
            throw new IllegalArgumentException(
                "File type not allowed: " + contentType + ". Please upload an image file.");
        }

        // Build unique filename
        String original  = extractFileName(part);
        String extension = "";
        if (original != null) {
            int dot = original.lastIndexOf('.');
            if (dot >= 0) extension = original.substring(dot).toLowerCase();
        }
        String uniqueName = UUID.randomUUID().toString() + extension;

        // Ensure target directory exists
        String absDir = webappRealPath + File.separator
                      + subDir.replace("/", File.separator);
        File dir = new File(absDir);
        if (!dir.exists()) dir.mkdirs();

        // Write file
        part.write(absDir + File.separator + uniqueName);

        return subDir + "/" + uniqueName;
    }

    /** Extracts the original filename from Content-Disposition header. */
    private static String extractFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                            .trim()
                            .replace("\"", "");
            }
        }
        return null;
    }
}