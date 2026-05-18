package skola;

import com.model.Notes;
import com.service.NotesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/notes")
public class NotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final NotesService notesService = new NotesService();

    public NotesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer studentId = (session != null) ? (Integer) session.getAttribute("student_id") : null;

        if (studentId == null) {
            studentId = 5;
        }

        List<Notes> notesList = notesService.getNotesByStudentId(studentId);
        request.setAttribute("notesList", notesList);

        request.getRequestDispatcher("/WEB-INF/pages/notes.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}