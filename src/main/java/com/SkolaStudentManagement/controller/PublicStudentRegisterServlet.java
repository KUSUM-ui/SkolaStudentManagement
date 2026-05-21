package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.service.RegisterService;
import com.SkolaStudentManagement.service.ScheduleService; // FIXED: Interacting with Service instead of DAO
import com.SkolaStudentManagement.utils.ImageUtil;

@WebServlet("/home/registerstudent")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class PublicStudentRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final RegisterService registerService = new RegisterService();
    private final ScheduleService scheduleService = new ScheduleService(); // FIXED: Initialized Service Layer instance

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadDropdowns(request);
        request.getRequestDispatcher("/WEB-INF/pages/StudentRegister.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trigger multipart parsing so getParameter() works reliably for all containers
        try { request.getParts(); } catch (Exception ignored) {}

        if ("loadSections".equals(request.getParameter("_action"))) {
            loadDropdowns(request);
            request.getRequestDispatcher("/WEB-INF/pages/StudentRegister.jsp")
                   .forward(request, response);
            return;
        }

        String firstName    = request.getParameter("first_name");
        String lastName     = request.getParameter("last_name");
        String dob          = request.getParameter("dob");
        String gender       = request.getParameter("gender");
        String email        = request.getParameter("email");
        String phone        = request.getParameter("number");
        String password     = request.getParameter("password");
        String gradeLevel   = request.getParameter("gradeLevel");
        String sectionId    = request.getParameter("sectionId");
        String programParam = request.getParameter("program");

        int facultyId = 0;
        if (programParam != null && !programParam.trim().isEmpty()) {
            try { 
                facultyId = Integer.parseInt(programParam.trim()); 
            } catch (NumberFormatException ignored) {
                facultyId = 0;
            }
        }

        String imagePath = "uploads/profiles/default.png";
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                ImageUtil util = new ImageUtil();
                boolean uploadSuccess = util.uploadImage(filePart, request, "profiles");
                
                if (uploadSuccess) {
                    String saved = (String) request.getAttribute("dbSavedPath");
                    if (saved != null) {
                        imagePath = saved;
                    }
                }
            }
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", "Photo upload failed: " + ex.getMessage());
            reloadForm(request, response);
            return;
        }

        try {
            registerService.addStudent(
                firstName, lastName,
                dob, gender,
                email, phone,
                password,
                facultyId, sectionId, gradeLevel,
                imagePath,
                "public"
            );

            request.setAttribute("successMessage", "true");
            request.setAttribute("registeredName", firstName);
            request.setAttribute("registeredPhoto", imagePath);
            
            request.getRequestDispatcher("/WEB-INF/pages/StudentRegister.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            reloadForm(request, response);
        }
    }

    private void loadDropdowns(HttpServletRequest request) {
        try {
            // FIXED: Using scheduleService to load layout data points
            List<Faculty> faculties = scheduleService.getAllFaculties();
            request.setAttribute("faculties", faculties);

            String programParam = request.getParameter("program");
            if (programParam != null && !programParam.trim().isEmpty()) {
                try {
                    int fId = Integer.parseInt(programParam.trim());
                    request.setAttribute("sections", scheduleService.getSectionsByFaculty(fId));
                    request.setAttribute("selectedFacultyId", fId);
                } catch (NumberFormatException ignored) {
                    request.setAttribute("sections", new java.util.ArrayList<>());
                }
            } else {
                List<Section> allSections = new java.util.ArrayList<>();
                for (Faculty f : faculties) {
                    allSections.addAll(scheduleService.getSectionsByFaculty(f.getFacultyId()));
                }
                request.setAttribute("sections", allSections);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void reloadForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadDropdowns(request);
        request.getRequestDispatcher("/WEB-INF/pages/StudentRegister.jsp")
               .forward(request, response);
    }
}