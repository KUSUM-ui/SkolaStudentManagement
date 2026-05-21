package com.SkolaStudentManagement.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * Utility for uploading student/admin profile images.
 *
 */
public class ImageUtil {

    public String getImageNameFromPart(Part part) {
        String originalName = part.getSubmittedFileName();
        String extension = ".png";
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();
        }
        return UUID.randomUUID().toString() + extension;
    }
    /**
     * Saves the uploaded file under webapp/uploads/{saveFolder}/ and sets
     * the request attribute "dbSavedPath" to the relative path stored in DB.
     *
     * @param part       the multipart file part
     * @param request    the current HTTP request (used to resolve real path)
     * @param saveFolder sub-folder name, e.g. "profiles"
     * @return true on success
     */
    public boolean uploadImage(Part part, HttpServletRequest request, String saveFolder) {
        // FIX: use getRealPath so path works on every environment
        String webappRoot = request.getServletContext().getRealPath("");
        String savePath   = webappRoot + File.separator + "uploads" + File.separator + saveFolder;

        File dir = new File(savePath);
        if (!dir.exists() && !dir.mkdirs()) {
            return false;
        }

        try {
            String imageName = getImageNameFromPart(part);
            part.write(savePath + File.separator + imageName);

            // Relative path stored in DB and used in <img src="...">
            request.setAttribute("dbSavedPath", "uploads/" + saveFolder + "/" + imageName);
            return true;

        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}