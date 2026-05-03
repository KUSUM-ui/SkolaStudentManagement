package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class ContactUsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ContactUsServlet" })
public class ContactUsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ContactUsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Just forward to the contact us page
		request.getRequestDispatcher("/WEB-INF/Contactus.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Retrieve form fields
		String name    = request.getParameter("name");
		String email   = request.getParameter("email");
		String message = request.getParameter("message");

		// Basic validation
		if (name == null || name.trim().isEmpty() ||
			email == null || email.trim().isEmpty() ||
			message == null || message.trim().isEmpty()) {

			request.setAttribute("message", " All fields are required.");
			request.setAttribute("msgType", "error");
			request.setAttribute("formName",  name);
			request.setAttribute("formEmail", email);
			request.getRequestDispatcher("C/WEB-INF/ontactus.jsp").forward(request, response);
			return;
		}

		// TODO: Save to database or send email
		// Example: ContactDAO.save(name, email, message);
		System.out.println("=== Contact Form Submission ===");
		System.out.println("Name   : " + name);
		System.out.println("Email  : " + email);
		System.out.println("Message: " + message);

		// Success
		request.setAttribute("message", "Thank you, " + name + "! Your message has been sent.");
		request.setAttribute("msgType", "success");
		request.getRequestDispatcher("/WEB-INF/Contactus.jsp").forward(request, response);
	}

}
