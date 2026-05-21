package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.Notes;
import com.SkolaStudentManagement.service.NoteService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student/notes/view")
public class ViewNotesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final NoteService viewnotesService =
            new NoteService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // CHECK LOGIN SESSION
        Integer sessionStudentId =
                (session != null)
                ? (Integer) session.getAttribute("studentId")
                : null;

        if (sessionStudentId == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // ================= DELETE NOTE =================
        if ("delete".equals(action)) {

            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {

                try {

                    int noteId = Integer.parseInt(idParam);

                    Notes note =
                            viewnotesService.getNoteById(noteId);

                    // SECURITY CHECK
                    if (note != null &&
                        note.getStudentId() == sessionStudentId) {

                        viewnotesService.deleteNote(noteId);
                    }

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            response.sendRedirect(
                    request.getContextPath() + "/student/notes");

            return;
        }

        // ================= VIEW NOTE =================
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/student/notes");

            return;
        }

        int noteId;

        try {

            noteId = Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/student/notes");

            return;
        }

        Notes note =
                viewnotesService.getNoteById(noteId);

        if (note == null) {

            response.sendRedirect(
                    request.getContextPath() + "/student/notes");

            return;
        }

        // SECURITY CHECK
        if (note.getStudentId() != sessionStudentId) {

            response.sendRedirect(
                    request.getContextPath() + "/student/notes");

            return;
        }

        request.setAttribute("note", note);

        request.getRequestDispatcher(
                "/WEB-INF/pages/viewnotes.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}