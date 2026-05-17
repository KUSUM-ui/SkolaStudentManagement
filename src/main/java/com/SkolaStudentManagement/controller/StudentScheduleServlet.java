package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.ScheduleModel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/StudentScheduleServlet" })
public class StudentScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ScheduleService service = new ScheduleService();

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

        try {
            List<ScheduleModel> scheduleList =
                    service.getScheduleForStudent(student.getSectionId());
            request.setAttribute("scheduleList", scheduleList);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid section: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load schedule.");
        }

        request.getRequestDispatcher("/WEB-INF/Student_Schedule.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}