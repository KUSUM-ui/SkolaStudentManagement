package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.ContactModel;
import com.SkolaStudentManagement.DAO.ContactDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ContactUsServlet")
public class ContactUsServlet extends HttpServlet {

    private final ContactDAO dao = new ContactDAO();

    // ── GET: show the contact page ────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/Contactus.jsp")
               .forward(request, response);
    }

    // ── POST: save the message ────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String message = request.getParameter("message");

        // ── Basic validation ──────────────────────────────────
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {

            request.setAttribute("msgType",   "error");
            request.setAttribute("message",   "All fields are required.");
            request.setAttribute("formName",  name);
            request.setAttribute("formEmail", email);
            request.getRequestDispatcher("/WEB-INF/Contactus.jsp")
                   .forward(request, response);
            return;
        }

        // ── Save to DB ────────────────────────────────────────
        ContactModel cm = new ContactModel(
                name.trim(),
                email.trim(),
                message.trim()
        );

        boolean saved = dao.save(cm);

        if (saved) {
            request.setAttribute("msgType", "success");
            request.setAttribute("message", "Thank you! Your message has been sent.");
        } else {
            request.setAttribute("msgType",   "error");
            request.setAttribute("message",   "Something went wrong. Please try again.");
            request.setAttribute("formName",  name);
            request.setAttribute("formEmail", email);
        }

        request.getRequestDispatcher("/WEB-INF/Contactus.jsp")
               .forward(request, response);
    }
}