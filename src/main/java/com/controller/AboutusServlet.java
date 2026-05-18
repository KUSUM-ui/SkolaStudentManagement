package com.controller;


import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class AboutusServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AboutusServlet" })
public class AboutusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AboutusServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// ── Stats (reuse same as HomeServlet) ──────────────────────────────
		request.setAttribute("institutionCount", "50+");
		request.setAttribute("activeStudents",   "1.2K");
		request.setAttribute("efficiencyRate",   "98%");
		request.setAttribute("userRating",       "4.9");

		// ── Team members ───────────────────────────────────────────────────
		// team member names here
		String[] teamNames  = { "Kusum", "Dilisha", "Shine", "Nishriti", "Aaditya" };
		String[] teamRoles = { "Full Stack Developer", "Frontend Developer", "Backend Developer", "UI/UX Designer", "Designer" };
		String[] teamDescs = {
			    "Building and managing both client-side and server-side of the application",
			    "Crafting beautiful and responsive interfaces with a focus on branding",
			    "Designing and maintaining databases and server-side logic",
			    "Designing clean user interfaces and crafting smooth, user-centered experiences",
			    "Creating visual graphics and design assets for the platform"
			};
			request.setAttribute("teamDescs", teamDescs);
		// Filenames of photos inside resources/images/
		String[] teamPhotos = { "kusum.png", "dilisha.JPG", "shine.jpeg", "nishriti.jpg", "aaditya.jpg" };

		request.setAttribute("teamNames",  teamNames);
		request.setAttribute("teamRoles",  teamRoles);
		request.setAttribute("teamPhotos", teamPhotos);

		// ── Forward to aboutus.jsp ─────────────────────────────────────────
		request.getRequestDispatcher("/pages/aboutus.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}