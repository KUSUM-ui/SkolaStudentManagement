package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.dao.ClassDAO; 
import com.SkolaStudentManagement.model.ClassReservation;
import com.SkolaStudentManagement.model.ClassModel;
import com.SkolaStudentManagement.model.SettingsStudentModel;
import com.SkolaStudentManagement.service.ClassReservationService;
import com.SkolaStudentManagement.service.StudentsSettingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/classes")
public class ClassReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final StudentsSettingService settingService = new StudentsSettingService();
    private final ClassReservationService reservationService = new ClassReservationService();
    private final ClassDAO classDAO = new ClassDAO(); // <-- 1. INITIALIZE YOUR DAO HERE

    private SettingsStudentModel getStudentFromSession(HttpSession session) {
        if (session == null) return null;
        Object id = session.getAttribute("studentId");
        if (id == null) return null;
        return settingService.getStudentById((int) id);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        SettingsStudentModel student = getStudentFromSession(session);

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Handle flash message passing from session context down to request layout
        request.setAttribute("success", session.getAttribute("reservationSuccess"));
        request.setAttribute("error", session.getAttribute("reservationError"));
        session.removeAttribute("reservationSuccess");
        session.removeAttribute("reservationError");

        // Load historical listings for this logged-in student profile
        List<ClassReservation> reservations = reservationService.getReservationsByStudent(student.getStudentId());
        request.setAttribute("reservations", reservations);
        request.setAttribute("student", student);

        // ─── 2. FETCH CLASSES AND SEND TO JSP ─────────────────────────────
        List<ClassModel> classes = classDAO.getAllClasses();
        request.setAttribute("classes", classes);
        // ──────────────────────────────────────────────────────────────────

        request.getRequestDispatcher("/WEB-INF/pages/class_student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        SettingsStudentModel student = getStudentFromSession(session);

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1. CAPTURE THE CLASS ID DROPDOWN PARAMETER
        String classIdStr  = request.getParameter("classId"); 
        String firstName   = request.getParameter("firstName");
        String dateStr     = request.getParameter("date");
        String timeFromStr = request.getParameter("timeFrom");
        String timeToStr   = request.getParameter("timeTo");
        String comment     = request.getParameter("comment");

        try {
            // 2. PARSE AND PASS IT DOWN TO YOUR SERVICE METHOD
            int classId = Integer.parseInt(classIdStr);

            // Adjust your reservationService method arguments signature to accept classId
            boolean saved = reservationService.addReservation(
                student.getStudentId(), 
                classId, // <-- Pass class selection id here
                firstName, 
                dateStr, 
                timeFromStr, 
                timeToStr, 
                comment
            );

            if (saved) {
                session.setAttribute("reservationSuccess", "Reservation submitted successfully! Waiting for administrative approval.");
            } else {
                session.setAttribute("reservationError", "Failed to submit request. Please try again.");
            }
        } catch (Exception e) {
            session.setAttribute("reservationError", "Invalid inputs: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/student/classes");
    }
}