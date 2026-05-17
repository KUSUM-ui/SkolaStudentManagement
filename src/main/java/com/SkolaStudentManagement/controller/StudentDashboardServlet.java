package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.AnnouncementDAO;
import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/StudentDashboardServlet" })
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Put student object in request scope for JSP
        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");
        request.setAttribute("student", student);

        // Fetch latest 3 announcements for the dashboard card
        try {
            AnnouncementDAO dao = new AnnouncementDAO();
            List<AnnouncementModel> announcements = dao.getLatestAnnouncements(3);
            request.setAttribute("announcements", announcements);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/Studentdashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}