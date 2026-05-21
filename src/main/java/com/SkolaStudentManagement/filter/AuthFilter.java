package com.SkolaStudentManagement.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication gate for all requests.
 *
 * FIX (critical): The original filter had:
 *     requestURI.contains("/")
 * which is ALWAYS true for every URL — meaning every page was
 * publicly accessible with zero authentication. This has been replaced
 * with an explicit whitelist of truly public paths.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest)  request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri         = req.getRequestURI();
        String contextPath = req.getContextPath();

        // ── Public paths (no login required) ────────────────────────────────
        boolean isPublic =
                uri.equals(contextPath + "/")                         ||
                uri.equals(contextPath + "/home")                     ||
                uri.equals(contextPath + "/about")                    || // ADD THIS
                uri.equals(contextPath + "/contact")                  || // ADD THIS
                uri.startsWith(contextPath + "/login")                ||
                uri.startsWith(contextPath + "/home/registerstudent") ||
                uri.startsWith(contextPath + "/student/register")     ||
                // Static resources
                uri.contains("/skola.css")                            ||
                uri.contains("/style.css")                            ||
                uri.contains("/images/")                              ||
                uri.contains("/uploads/")                             ||
                uri.contains("/css/");

        // ── Session check ────────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        boolean loggedIn    = (session != null && session.getAttribute("userEmail") != null);

        if (isPublic || loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(contextPath + "/home");
        }
    }
}