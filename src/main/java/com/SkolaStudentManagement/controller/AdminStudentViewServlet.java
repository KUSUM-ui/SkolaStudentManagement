package com.SkolaStudentManagement.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.StudentService;

import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/students/view")
public class AdminStudentViewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String facultyId = request.getParameter("course");
            String sectionId = request.getParameter("section");
            String semester  = request.getParameter("semester");

            List<StudentModel> students = studentService.getFilteredStudents(facultyId, sectionId, semester);
            List<Faculty> faculties = studentService.getAllFaculties();
            List<Section> sections = studentService.getSectionsForFacultyFilter(facultyId, faculties);

            request.setAttribute("students",        students);
            request.setAttribute("faculties",       faculties);
            request.setAttribute("sections",        sections);
            request.setAttribute("selectedCourse",  facultyId != null ? facultyId.trim() : "");
            request.setAttribute("selectedSection", sectionId != null ? sectionId.trim() : "");
            request.setAttribute("selectedSemester",semester  != null ? semester.trim()  : "");

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            // Preserve filter state so the form retains selected values after an error
            String facultyId = request.getParameter("course");
            String sectionId = request.getParameter("section");
            String semester  = request.getParameter("semester");
            request.setAttribute("selectedCourse",   facultyId != null ? facultyId.trim() : "");
            request.setAttribute("selectedSection",  sectionId != null ? sectionId.trim() : "");
            request.setAttribute("selectedSemester", semester  != null ? semester.trim()  : "");
            try {
                request.setAttribute("faculties", studentService.getAllFaculties());
                request.setAttribute("sections",  studentService.getSectionsForFacultyFilter(facultyId, null));
            } catch (Exception ex) { ex.printStackTrace(); }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/StudentDetails.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

