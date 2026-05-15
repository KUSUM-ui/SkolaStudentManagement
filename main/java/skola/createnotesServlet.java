package skola;

import com.service.CreateNoteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student/notes/create")
public class createnotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CreateNoteService createNoteService = new CreateNoteService();

    public createnotesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/createnotes.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer studentId = (session != null) ? (Integer) session.getAttribute("student_id") : null;

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String title   = request.getParameter("title");
        String content = request.getParameter("body");

        boolean saved = createNoteService.saveNote(studentId, title, content);

        if (saved) {
            session.setAttribute("noteSuccess", "Note saved successfully!");
        } else {
            session.setAttribute("noteError", "Failed to save note. Content cannot be empty.");
        }

        response.sendRedirect(request.getContextPath() + "/createnotesServlet");
    }
}