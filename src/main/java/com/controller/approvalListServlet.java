package com.controller;

import java.io.IOException;
import java.util.List;

import com.dao.ApprovalListDAO;
import com.model.ApprovalListModel;
import com.service.ApprovalListService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class approvalListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public approvalListServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        ApprovalListDAO dao = new ApprovalListDAO();
        
        // Get search query (empty string if nothing typed)
        String search = request.getParameter("search");
        if (search == null) search = "";

        // Search or get all
        List<ApprovalListModel> pendingStudents;
        if (!search.trim().isEmpty()) {
        	pendingStudents = dao.searchStudents(search.trim());
        } else {
            pendingStudents = dao.getPendingStudents();
        }

        // Send to JSP
        request.setAttribute("pendingStudents", pendingStudents);
        request.setAttribute("searchQuery", search); // keeps text in search box
        request.getSession().setAttribute("adminName", "Admin");
        request.getRequestDispatcher("/pages/approvalList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("approve".equals(action)) {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            ApprovalListService service = new ApprovalListService();
            boolean success = service.approveStudent(studentId);

            if (success) {
                // Reload fresh list and show message
                ApprovalListDAO dao = new ApprovalListDAO();
                List<ApprovalListModel> pendingStudents = dao.getPendingStudents();
                request.setAttribute("pendingStudents", pendingStudents);
                request.setAttribute("adminName", "Admin");
                request.setAttribute("successMessage", "Student approved successfully!");
                request.getRequestDispatcher("/pages/approvalList.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/approvalListServlet");
            }
        } else {
            doGet(request, response);
        }
    }
}