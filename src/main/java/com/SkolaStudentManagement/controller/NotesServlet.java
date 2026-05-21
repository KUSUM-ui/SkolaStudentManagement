package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.Notes;
import com.SkolaStudentManagement.model.SettingsStudentModel;
import com.SkolaStudentManagement.service.NoteService;
import com.SkolaStudentManagement.service.StudentsSettingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/notes")
public class NotesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final NoteService notesService = new NoteService();
    private final StudentsSettingService settingService = new StudentsSettingService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        SettingsStudentModel student = settingService.getStudentById(studentId);

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user typed a search query (?q=...)
        String keyword = request.getParameter("q");

        List<Notes> notesList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Search mode — hits DB with LIKE query
            notesList = notesService.searchNotesByTitle(studentId, keyword.trim());
            request.setAttribute("searchKeyword", keyword.trim());
        } else {
            // Normal mode — load all notes
            notesList = notesService.getNotesByStudentId(studentId);
            request.setAttribute("searchKeyword", "");
        }

        request.setAttribute("notesList", notesList);
        request.setAttribute("student", student);

        // FIX: correct JSP path (was /WEB-INF/notes.jsp)
        request.getRequestDispatcher("/WEB-INF/pages/notes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}