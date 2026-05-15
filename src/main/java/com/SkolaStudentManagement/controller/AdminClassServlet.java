package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.ClassReservationDAO;
import com.SkolaStudentManagement.Model.Classreservationmodel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/AdminClassServlet" })
public class AdminClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TODO: re-enable session check before production
        // HttpSession session = request.getSession(false);
        // if (session == null || session.getAttribute("adminId") == null) {
        //     response.sendRedirect(request.getContextPath() + "/login");
        //     return;
        // }

        ClassReservationDAO dao = new ClassReservationDAO();
        List<Classreservationmodel> reservations = dao.getAllReservations();
        request.setAttribute("reservations", reservations);

        request.getRequestDispatcher("/WEB-INF/class_admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TODO: re-enable session check before production
        // HttpSession session = request.getSession(false);
        // if (session == null || session.getAttribute("adminId") == null) {
        //     response.sendRedirect(request.getContextPath() + "/login");
        //     return;
        // }

        String reservationIdStr = request.getParameter("reservationId");
        String action           = request.getParameter("action"); // "Approved" or "Disapproved"

        if (reservationIdStr != null && action != null) {
            try {
                int reservationId = Integer.parseInt(reservationIdStr);
                ClassReservationDAO dao = new ClassReservationDAO();

                if (dao.updateStatus(reservationId, action)) {
                    request.setAttribute("success", "Reservation " + action.toLowerCase() + " successfully.");
                } else {
                    request.setAttribute("error", "Failed to update status. Please try again.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid reservation ID.");
            }
        }

        doGet(request, response);
    }
}