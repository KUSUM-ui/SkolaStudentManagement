package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import java.util.Base64;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.RegisterService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;



/**
 * Servlet implementation class ImageServlet
 */
@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RegisterService service = new RegisterService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email = request.getParameter("email");
			StudentModel student = service.getStudentByEmail(email);
			
			if (student == null|| student.getImage() == null ) {
				return;
			}
		byte[] imageBytes = Base64.getDecoder().decode(student.getImage());
		
		response.setContentType("image/jpeg");
		
		response.getOutputStream().write(imageBytes);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
