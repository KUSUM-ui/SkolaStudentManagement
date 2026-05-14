package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.ClassReservationDAO;
import com.SkolaStudentManagement.Model.Classreservationmodel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet(urlPatterns = { "/ClassReservationServlet" })
public class ClassReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── GET: load the class reservation page ─────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student = (SettingsStudentModel) session.getAttribute("student");
        ClassReservationDAO dao = new ClassReservationDAO();

        // Load this student's reservations for the status table
        List<Classreservationmodel> reservations = dao.getReservationsByStudent(student.getStudentId());
        request.setAttribute("reservations", reservations);
        request.setAttribute("student", student);

        request.getRequestDispatcher("/WEB-INF/class_student.jsp").forward(request, response);
    }

    // ── POST: submit a new reservation ───────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student = (SettingsStudentModel) session.getAttribute("student");

        String firstName = request.getParameter("firstName");
        String dateStr   = request.getParameter("date");
        String timeFrom  = request.getParameter("timeFrom");
        String timeTo    = request.getParameter("timeTo");
        String comment   = request.getParameter("comment");

        // ── Validation ───────────────────────────────────────────────
        if (firstName == null || firstName.trim().isEmpty() ||
            dateStr   == null || dateStr.trim().isEmpty()   ||
            timeFrom  == null || timeFrom.trim().isEmpty()  ||
            timeTo    == null || timeTo.trim().isEmpty()) {

            request.setAttribute("error", "First name, date, and time are required.");
            doGet(request, response);
            return;
        }

        try {
            Classreservationmodel r = new Classreservationmodel();
            r.setStudentId(student.getStudentId());
            r.setFirstName(firstName.trim());
            r.setDate(Date.valueOf(dateStr));           // expects yyyy-MM-dd from <input type="date">
            r.setTimeFrom(Time.valueOf(timeFrom + ":00")); // expects HH:mm from <input type="time">
            r.setTimeTo(Time.valueOf(timeTo + ":00"));
            r.setComment(comment != null ? comment.trim() : "");

            ClassReservationDAO dao = new ClassReservationDAO();
            if (dao.addReservation(r)) {
                request.setAttribute("success", "Reservation submitted successfully. Waiting for admin approval.");
            } else {
                request.setAttribute("error", "Failed to submit reservation. Please try again.");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date or time format.");
        }

        doGet(request, response);
    }
}