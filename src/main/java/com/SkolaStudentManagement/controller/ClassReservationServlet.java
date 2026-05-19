package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.ClassModel;
import com.SkolaStudentManagement.Model.Classreservationmodel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Service.ClassReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/student/ClassReservation" })
public class ClassReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ClassReservationService service = new ClassReservationService();

    // ── GET: load the page ────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");

        // Classes for the dropdown
        List<ClassModel> classes = service.getAllClasses();

        // Student's own reservations for the status table
        List<Classreservationmodel> reservations =
                service.getReservationsByStudent(student.getStudentId());

        request.setAttribute("student",      student);
        request.setAttribute("classes",      classes);
        request.setAttribute("reservations", reservations);

        request.getRequestDispatcher("/WEB-INF/class_student.jsp")
               .forward(request, response);
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

        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");

        String error = service.submitReservation(
                student.getStudentId(),
                request.getParameter("firstName"),
                request.getParameter("classId"),      // new param
                request.getParameter("date"),
                request.getParameter("timeFrom"),
                request.getParameter("timeTo"),
                request.getParameter("comment")
        );

        if (error != null) {
            request.setAttribute("error", error);
        } else {
            request.setAttribute("success",
                    "Reservation submitted successfully. Waiting for admin approval.");
        }

        doGet(request, response);
    }
}