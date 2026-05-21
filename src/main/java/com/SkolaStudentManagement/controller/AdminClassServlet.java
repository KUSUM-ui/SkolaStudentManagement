package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.ClassReservation;
import com.SkolaStudentManagement.service.ClassReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * AdminClassServlet — admin management of class reservations.
 *
 * GET  /admin/classes           → list all reservations, optional ?filter=Pending|Approved|Rejected
 * POST /admin/classes           → approve or reject a reservation
 *
 * FIX summary vs original:
 *  1. Original called DAO directly — violates MVC. Now goes through
 *     ClassReservationService which performs validation.
 *  2. Added admin auth guard (original had none — any user could access).
 *  3. Added ?filter= support for no-JS status filtering.
 *  4. PRG pattern on POST (redirect after post) to prevent form resubmission.
 *  5. Flash messages use session scope + request transfer, matching the rest
 *     of the system's established pattern.
 */
@WebServlet("/admin/classes")
public class AdminClassServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ClassReservationService service = new ClassReservationService();

    // ── GET ──────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth guard — admin only
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Transfer PRG flash messages
        HttpSession session = request.getSession(false);
        if (session != null) {
            transferFlash(session, request, "successMessage");
            transferFlash(session, request, "errorMessage");
        }

        // Status filter (no JS — plain GET param from anchor links or form submit)
        String filter = request.getParameter("filter");
        List<ClassReservation> reservations = service.getReservationsByStatus(filter);

        request.setAttribute("reservations",  reservations);
        request.setAttribute("activeFilter",  (filter != null && !filter.trim().isEmpty()) ? filter : "all");

        request.getRequestDispatcher("/WEB-INF/pages/admin_class.jsp")
               .forward(request, response);
    }

    // ── POST ─────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth guard
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr  = request.getParameter("reservationId");
        String action = request.getParameter("action");   // "approve" or "reject"

        HttpSession session = request.getSession(true);

        try {
            if (idStr == null || idStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Missing reservation ID.");
            }
            int reservationId = Integer.parseInt(idStr.trim());

            // Validation and status logic fully delegated to service layer
            boolean updated = service.updateStatus(reservationId, action);

            if (updated) {
                String displayStatus = "approve".equalsIgnoreCase(action) ? "Approved" : "Rejected";
                session.setAttribute("successMessage", "Reservation " + displayStatus + " successfully.");
            } else {
                session.setAttribute("errorMessage", "Update failed. The reservation may not exist.");
            }

        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
        }

        // PRG: redirect after POST
        response.sendRedirect(request.getContextPath() + "/admin/classes");
    }

    // ── Private helpers ──────────────────────────────────────────────────────

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "admin".equals(session.getAttribute("userRole"));
    }

    private void transferFlash(HttpSession session, HttpServletRequest request, String key) {
        Object value = session.getAttribute(key);
        if (value != null) {
            request.setAttribute(key, value);
            session.removeAttribute(key);
        }
    }
}