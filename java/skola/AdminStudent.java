package skola;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.service.TotalStudent;

@WebServlet("/AdminStudent")
public class AdminStudent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminStudent() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        TotalStudent totalStudentService = new TotalStudent();
        int totalStudents = 0;

        try {
            totalStudents = totalStudentService.getTotalStudentCount();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalStudents", totalStudents);
        request.getRequestDispatcher("/WEB-INF/pages/AdminStudent.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}