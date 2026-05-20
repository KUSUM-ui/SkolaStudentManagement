package com.SkolaManagement.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AboutusServlet
 */
@WebServlet("/AboutusServlet")
public class AboutusServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor
     */
    public AboutusServlet() {
        super();
    }

    /**
     * Handles GET requests
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.getRequestDispatcher("/WEB-INF/Aboutus.jsp").forward(request, response);
    }

    /**
     * Handles POST requests
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}