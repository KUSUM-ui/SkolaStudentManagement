package com.SkolaStudentManagement.controller;

import java.io.IOException;

import com.SkolaStudentManagement.utils.CookieUtil;
import com.SkolaStudentManagement.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Invalidates the user session, clears auth cookies, and redirects to /login.
 */
@WebServlet(urlPatterns = { "/LogoutServlet", "/logout" })
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Use existing utility instead of raw HttpSession calls
        SessionUtil.invalidateSession(request);

        // Clear the remember-me cookie through the shared utility
        CookieUtil.deleteCookie(response, "userEmail");

        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
