package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.service.NoteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/student/notes/create")
public class CreateNotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NoteService noteService = new NoteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        // FIX: Consistently validate via "studentId" attribute
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Catch flash notifications safely
        request.setAttribute("noteSuccess", session.getAttribute("noteSuccess"));
        request.setAttribute("noteError",   session.getAttribute("noteError"));
        session.removeAttribute("noteSuccess");
        session.removeAttribute("noteError");

        request.getRequestDispatcher("/WEB-INF/pages/createnotes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // FIX: Extract id directly from the uniform session attribute
        int studentId = (int) session.getAttribute("studentId");

        String title   = request.getParameter("title");
        // NOTE: If your frontend textarea is named "content" instead of "body", this handles both!
        String content = request.getParameter("body");
        if (content == null) {
            content = request.getParameter("content");
        }
        
        boolean saved = noteService.saveNote(studentId, title, content);

        if (saved) {
            session.setAttribute("noteSuccess", "Note saved successfully!");
            response.sendRedirect(request.getContextPath() + "/student/notes");
        } else {
            session.setAttribute("noteError", "Failed to save note. Content cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/student/notes/create");
        }
    }
}