package skola;

import com.DAO.ViewnotesDAO;
import com.model.Viewnotes;
import com.service.ViewnotesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student/notes/view")
public class viewnotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ViewnotesService viewnotesService = new ViewnotesService();
    private final ViewnotesDAO viewnotesDAO = new ViewnotesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // Handle delete
        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int noteId = Integer.parseInt(idParam);
                    Integer sessionStudentId = (Integer) session.getAttribute("student_id");
                    Viewnotes note = viewnotesDAO.getNoteById(noteId);

                    if (note != null && sessionStudentId != null && note.getStudentId() == sessionStudentId) {
                        viewnotesDAO.deleteNote(noteId);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect(request.getContextPath() + "/student/notes");
            return;
        }

        // Handle view
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/notes");
            return;
        }

        int noteId;
        try {
            noteId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/notes");
            return;
        }

        Viewnotes note = viewnotesService.getNoteById(noteId);

        if (note == null) {
            response.sendRedirect(request.getContextPath() + "/student/notes");
            return;
        }

        Integer sessionStudentId = (Integer) session.getAttribute("student_id");
        if (sessionStudentId == null || note.getStudentId() != sessionStudentId) {
            response.sendRedirect(request.getContextPath() + "/student/notes");
            return;
        }

        request.setAttribute("note", note);
        request.getRequestDispatcher("/WEB-INF/pages/viewnotes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}