package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.LoginService;
import com.SkolaStudentManagement.service.RegisterService;
import com.SkolaStudentManagement.utils.CookieUtil;
import com.SkolaStudentManagement.utils.SessionUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final LoginService    loginService    = new LoginService();
    private final RegisterService registerService = new RegisterService();

    // ===================== GET =====================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Transfer registration success flash (set by PublicStudentRegisterServlet)
        if (session != null) {
            Object regSuccess = session.getAttribute("registrationSuccess");
            if (regSuccess != null) {
                request.setAttribute("registrationSuccess", regSuccess);
                session.removeAttribute("registrationSuccess");
            }
        }

        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    // ===================== POST =====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        // Guard against null params before trimming — prevents NPE masking the real error
        if (email == null || password == null || role == null
                || email.trim().isEmpty() || password.trim().isEmpty() || role.trim().isEmpty()) {
            request.setAttribute("error", "Email, password, and role are required.");
            forward(request, response);
            return;
        }

        try {
            boolean isValid = loginService.login(email.trim(), password.trim(), role.trim());

            if (isValid) {

                // Destroy old session, create fresh one
                SessionUtil.invalidateSession(request);
                HttpSession session = request.getSession(true);

                session.setAttribute("userEmail", email.trim());
                session.setAttribute("userRole",  role.trim().toLowerCase());
                session.setMaxInactiveInterval(60 * 60);

                CookieUtil.addCookie(response, "role",      role.trim().toLowerCase(), 60 * 60);
                CookieUtil.addCookie(response, "userEmail", email.trim(),              60 * 60);

                String userRole = role.trim().toLowerCase();

                if ("admin".equals(userRole)) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    return;
                }

                if ("student".equals(userRole)) {
                    // Look up the student's approval status before granting full access
                    StudentModel student = registerService.getStudentByEmail(email.trim());

                    if (student == null) {
                        // Email authenticated but no student record found — should not happen
                        request.setAttribute("error", "Account not found. Please contact admin.");
                        SessionUtil.invalidateSession(request);
                        forward(request, response);
                        return;
                    }

                    // Store student info in session
                    session.setAttribute("studentId",     student.getStudentId());
                    session.setAttribute("studentName",   student.getFirstName() + " " + student.getLastName());
                    session.setAttribute("studentStatus", student.getStatus());
                    session.setAttribute("studentSectionId",  student.getSectionId());
                    session.setAttribute("studentFacultyId",  student.getFacultyId());
                    session.setAttribute("studentGradeLevel", student.getGradeLevel());

                    if ("APPROVED".equalsIgnoreCase(student.getStatus())) {
                        // Full access
                        response.sendRedirect(request.getContextPath() + "/student/dashboard");
                    } else {
                        // PENDING (or any non-approved state) — limited access: own details only
                        response.sendRedirect(request.getContextPath()
                            + "/student/details?id=" + student.getStudentId());
                    }
                    return;
                }

                // Unknown role
                request.setAttribute("error", "Invalid role.");
                forward(request, response);

            } else {
                request.setAttribute("error", "Invalid email, password, or role.");
                forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again.");
            forward(request, response);
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }
}