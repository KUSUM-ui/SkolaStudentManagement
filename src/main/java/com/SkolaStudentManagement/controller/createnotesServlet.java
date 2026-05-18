package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.CreateNote;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Service.CreateNoteService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/student/notes/create")
public class createnotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CreateNoteService createNoteService = new CreateNoteService();

    public createnotesServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Move flash messages from session → request so JSP can display them
        request.setAttribute("noteSuccess", session.getAttribute("noteSuccess"));
        request.setAttribute("noteError",   session.getAttribute("noteError"));
        session.removeAttribute("noteSuccess");
        session.removeAttribute("noteError");

        request.getRequestDispatcher("/WEB-INF/createnotes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Pull student_id from the model stored in session
        SettingsStudentModel student = (SettingsStudentModel) session.getAttribute("student");
        int studentId = student.getStudentId();

        String title   = request.getParameter("title");
        String content = request.getParameter("body");

        boolean saved = createNoteService.saveNote(studentId, title, content);

        if (saved) {
            session.setAttribute("noteSuccess", "Note saved successfully!");
        } else {
            session.setAttribute("noteError", "Failed to save note. Content cannot be empty.");
        }

        response.sendRedirect(request.getContextPath() + "/student/notes/create");
    }
}